// import 'dart:async';

// import 'package:agrigreens/services/google_sheets_service.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class VarController extends GetxController {
  // RxInt n = 5.obs;
  // void getN() {
  //   n.value = n.value + 1;
  //   print(n.value);
  // }

  // RxString m = ''.obs;
  // void updateValue(String message) {
  //   m.value = message;
  // }
  // RxString PH = "0".obs;
  // void updatePH(String message) {
  //   PH.value = message;
  // }

  RxString temp = "0".obs;
  void updateTemp(String message) {
    temp.value = message;
  }

  var timestamps = <DateTime>[].obs;
  var sensorData = <double>[].obs;
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

  // var data = <ChartData>[].obs;
  // int lastRowFetched = 0;

  @override
  void onInit() {
    // fetchInitialData();
    // Timer.periodic(Duration(minutes: 4), (timer) => fetchNewData());
    super.onInit();
  }

//   Future<void> fetchInitialData() async {
//     final service = GoogleSheetsService();
//     final initialData = await service.fetchLast360Rows();
//     data.value = initialData.map((row) {
//       final timestamp = DateTime.parse(row[0]);
//       final value1 = double.parse(row[1]);
//       final value2 = double.parse(row[2]);
//       final value3 = double.parse(row[3]);
//       return ChartData(timestamp, value1, value2, value3);
//     }).toList();
//     lastRowFetched = data.length;
//   }

//   Future<void> fetchNewData() async {
//     final service = GoogleSheetsService();
//     final allData = await service.fetchData();
//     final newData = allData.sublist(lastRowFetched);
//     final newChartData = newData.map((row) {
//       final timestamp = DateTime.parse(row[0]);
//       final value1 = double.parse(row[1]);
//       final value2 = double.parse(row[2]);
//       final value3 = double.parse(row[3]);
//       return ChartData(timestamp, value1, value2, value3);
//     }).toList();
//     data.addAll(newChartData);
//     lastRowFetched = allData.length;

//     // Keep only the last 360 readings
//     if (data.length > 360) {
//       data.value = data.sublist(data.length - 360);
//     }
//   }
}

// class ChartData {
//   final DateTime timestamp;
//   final double value1;
//   final double value2;
//   final double value3;

//   ChartData(this.timestamp, this.value1, this.value2, this.value3);
// }
