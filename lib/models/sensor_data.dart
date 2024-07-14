import 'package:get/get.dart';

class SensorData {
  RxList<DateTime> timestamps = <DateTime>[].obs;
  RxList<double> sensorData = <double>[].obs;
  RxString reading = "0".obs;

  void addData(DateTime timestamp, String message) {
    reading.value = message;
    if (sensorData.length >= 360) {
      for (int i = 1; i < sensorData.length; i++) {
        sensorData[i - 1] = sensorData[i];
        timestamps[i - 1] = timestamps[i];
      }
    }
    print(sensorData.length);
    sensorData.add(double.parse(message));
    timestamps.add(timestamp);
  }
}
