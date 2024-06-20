import 'package:agrigreens/MQTT/mqtt_client.dart';

MQTTClientWrapper client = createClient();

void subscribe() {
  // system[x]/variable should have a unique identifier for each device that publishes on the same topic
  client.subscribeToTopic('$EMAIL/system1/ph');
  client.subscribeToTopic("$EMAIL/system1/temp");
}

void unsubscribe() {
  client.unsubscribeFromTopic('$EMAIL/system1/ph');
  client.unsubscribeFromTopic('$EMAIL/system1/temp');
}

bool isLoggedIn = false;
late String EMAIL;
