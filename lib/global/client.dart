import 'package:agrigreens/MQTT/mqtt_client.dart';

MQTTClientWrapper client = createClient();

void subscribe() {
  // system[x]/variable should have a unique identifier for each device that publishes on the same topic
  client.subscribeToTopic('system1/ph');
  client.subscribeToTopic("system1/temp");
}
