import 'dart:async';
import 'dart:io';

import 'package:agrigreens/global/client.dart';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../var_controller.dart';

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
        _connectClient();
      }
    }
  }

  void prepareMqttClient() {
    _setupMqttClient();
    _connectClient();
  }

  Future<void> _connectClient() async {
    try {
      print('client connecting....');
      connectionState = MqttCurrentConnectionState.CONNECTING;
      await client.connect('test', 'test');
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
      return;
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

  void subscribeToTopic(String topicName) {
    print('Subscribing to the $topicName topic');
    client.subscribe(topicName, MqttQos.atMostOnce);

    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final recMess = c[0].payload as MqttPublishMessage;
      final String topic = c[0].topic;
      var message =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      print('YOU GOT A NEW MESSAGE:' + message);

      if (topic == 'system1/ph') {
        varController.PH(message);
      } else if (topic == 'system1/temp') {
        varController.temp(message);
      }
    });
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
    _reconnect();
  }

  void _onConnected() {
    connectionState = MqttCurrentConnectionState.CONNECTED;
    print('OnConnected client callback - Client connection was successful');
    subscribe();
  }

  void _reconnect() {
    if (connectionState == MqttCurrentConnectionState.DISCONNECTED ||
        connectionState == MqttCurrentConnectionState.ERROR_WHEN_CONNECTING) {
      print('Attempting to reconnect...');
      Future.delayed(const Duration(seconds: 3));
      _connectClient();
    }
  }

  void refreshConnection() {
    _connectivity.checkConnectivity().then((result) {
      _handleConnectivityChange(result);
    });
    _reconnect();
  }
}
