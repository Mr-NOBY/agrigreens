import 'package:get/get.dart';

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
  RxString PH = "0".obs;
  void updatePH(String message) {
    PH.value = message;
  }

  RxString temp = "0".obs;
  void updateTemp(String message) {
    temp.value = message;
  }
}
