import 'dart:math';

import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';

import 'MQTT/mqtt_client.dart';

class VarController extends GetxController {
  RxInt n = 5.obs;

  void getN() {
    n.value = n.value + 1;
    print(n.value);
  }
}
