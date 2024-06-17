import 'package:agrigreens/var_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'global/app_themes.dart';

class Variable extends StatelessWidget {
  Variable({super.key});
  final controller = Get.put(VarController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Theme(
        data: Themes.mainthemeData,
        child: Scaffold(
          appBar: AppBar(
            title: Text("AgriGreens"),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(
                  () => Text(
                    controller.PH.value,
                  ),
                ),
                Obx(
                  () => Text(
                    controller.temp.value,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
