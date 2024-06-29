import 'dart:async';
import 'dart:io';

import 'package:agrigreens/global/client.dart';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:agrigreens/var_controller.dart';

MQTTClientWrapper createClient() {
  MQTTClientWrapper newclient = MQTTClientWrapper();
  newclient.prepareMqttClient();
  return newclient;
}

enum MqttCurrentConnectionState {
  IDLE,
  CONNECTING,
  CONNECTED,
  DISCONNECTED,
  ERROR_WHEN_CONNECTING
}

enum MqttSubscriptionState { IDLE, SUBSCRIBED }

class MQTTClientWrapper {
  late MqttServerClient client;
  final varController = Get.put(VarController());
  final Connectivity _connectivity = Connectivity();

  MqttCurrentConnectionState connectionState = MqttCurrentConnectionState.IDLE;
  MqttSubscriptionState subscriptionState = MqttSubscriptionState.IDLE;

  bool _hasShownConnectionFailureSnackbar = false;
  bool _hasShownConnectionRestorationSnackbar = false;
  bool _isConnected = false;
  bool _isConnecting = false;
  Timer? _reconnectTimer;

  MQTTClientWrapper() {
    _connectivity.onConnectivityChanged.listen(_handleConnectivityChange);
  }

  void _handleConnectivityChange(ConnectivityResult result) {
    print('Connectivity changed: $result');
    if (result == ConnectivityResult.none) {
      if (!_hasShownConnectionFailureSnackbar) {
        Get.snackbar(
          'No Internet Connection',
          'Please check your internet connection.',
          snackPosition: SnackPosition.BOTTOM,
        );
        _hasShownConnectionFailureSnackbar = true;
        _hasShownConnectionRestorationSnackbar = false;
      }
      client.disconnect();
      connectionState = MqttCurrentConnectionState.DISCONNECTED;
    } else {
      if (connectionState == MqttCurrentConnectionState.DISCONNECTED ||
          connectionState == MqttCurrentConnectionState.ERROR_WHEN_CONNECTING) {
        _scheduleReconnect();
      }
    }
  }

  void prepareMqttClient() {
    _setupMqttClient();
    _connectClient();
  }

  Future<void> _connectClient() async {
    if (_isConnecting) return;
    try {
      print('client connecting....');
      connectionState = MqttCurrentConnectionState.CONNECTING;
      _isConnecting = true;
      await client.connect('test', 'test');
      _isConnected = true;
    } on Exception catch (e) {
      print('client exception - $e');
      connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
      client.disconnect();
      if (!_hasShownConnectionFailureSnackbar) {
        Get.snackbar(
          'Connection Failed',
          'Unable to connect to the MQTT broker.',
          snackPosition: SnackPosition.BOTTOM,
        );
        _hasShownConnectionFailureSnackbar = true;
        _hasShownConnectionRestorationSnackbar = false;
      }
    } finally {
      _isConnecting = false;
    }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      connectionState = MqttCurrentConnectionState.CONNECTED;
      print('client connected');
      if (!_hasShownConnectionRestorationSnackbar) {
        Get.snackbar(
          'Connected to MQTT Broker',
          'You are now connected to the MQTT broker.',
          snackPosition: SnackPosition.BOTTOM,
        );
        _hasShownConnectionRestorationSnackbar = true;
        _hasShownConnectionFailureSnackbar = false;
      }
      subscribeToTopic('Dart/Mqtt_client/testtopic');
      _publishMessage('Hello');
    } else {
      print(
          'ERROR client connection failed - disconnecting, status is ${client.connectionStatus}');
      connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
      client.disconnect();
      if (!_hasShownConnectionFailureSnackbar) {
        Get.snackbar(
          'Connection Failed',
          'Unable to connect to the MQTT broker.',
          snackPosition: SnackPosition.BOTTOM,
        );
        _hasShownConnectionFailureSnackbar = true;
        _hasShownConnectionRestorationSnackbar = false;
      }
    }
  }

  void _setupMqttClient() {
    client = MqttServerClient.withPort(
        'fe5d3b620e1e48eeb93a1be1be1076aa.s1.eu.hivemq.cloud', 'test', 8883);
    client.secure = true;
    client.securityContext = SecurityContext.defaultContext;
    client.keepAlivePeriod = 20;
    client.onDisconnected = _onDisconnected;
    client.onConnected = _onConnected;
    client.onSubscribed = _onSubscribed;
  }

  Future<void> subscribeToTopic(String topicName) async {
    if (!_isConnected) {
      await _connectClient();
    }

    if (_isConnected) {
      print('Subscribing to the $topicName topic');
      client.subscribe(topicName, MqttQos.exactlyOnce);

      client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
        final recMess = c[0].payload as MqttPublishMessage;
        final String topic = c[0].topic;
        var message =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

        print('YOU GOT A NEW MESSAGE: $message');

        if (topic == '$EMAIL/system1/ph') {
          varController.PH(message);
          varController.addData(double.parse(message), DateTime.now());
        } else if (topic == '$EMAIL/system1/temp') {
          varController.temp(message);
        }
      });
    }
  }

  void unsubscribeFromTopic(String topicName) {
    if (_isConnected) {
      client.unsubscribe(topicName);
      print('Unsubed from the $topicName topic');
    }
  }

  void _publishMessage(String message) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);

    print(
        'Publishing message "$message" to topic ${'Dart/Mqtt_client/testtopic'}');
    final payload = builder.payload;
    if (payload != null) {
      client.publishMessage(
          'Dart/Mqtt_client/testtopic', MqttQos.exactlyOnce, payload);
    } else {
      print('Error: Payload is null');
    }
  }

  void _onSubscribed(String topic) {
    print('Subscription confirmed for topic $topic');
    subscriptionState = MqttSubscriptionState.SUBSCRIBED;
  }

  void _onDisconnected() {
    print('OnDisconnected client callback - Client disconnection');
    connectionState = MqttCurrentConnectionState.DISCONNECTED;
    _isConnected = false;
    _scheduleReconnect();
  }

  void _onConnected() {
    connectionState = MqttCurrentConnectionState.CONNECTED;
    _isConnected = true;
    print('OnConnected client callback - Client connection was successful');
    if (isLoggedIn) {
      subscribe();
    }
    // subscribe();
  }

  void _scheduleReconnect() {
    if (_reconnectTimer?.isActive ?? false) return;
    _reconnectTimer = Timer(const Duration(seconds: 3), () {
      if (connectionState == MqttCurrentConnectionState.DISCONNECTED ||
          connectionState == MqttCurrentConnectionState.ERROR_WHEN_CONNECTING) {
        print('Attempting to reconnect...');
        _connectClient();
      }
    });
  }

  void refreshConnection() {
    _connectivity.checkConnectivity().then((result) {
      _handleConnectivityChange(result);
    });
    _scheduleReconnect();
  }
}
