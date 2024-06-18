import 'package:agrigreens/var_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'global/app_themes.dart';
import 'global/client.dart';

class Variable extends StatelessWidget {
  Variable({super.key});
  final controller = Get.put(VarController());

  Future<void> _refreshConnection() async {
    client.refreshConnection();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Theme(
        data: Themes.mainthemeData,
        child: Scaffold(
          appBar: AppBar(
            title: Text("AgriGreens"),
          ),
          body: RefreshIndicator(
            onRefresh: _refreshConnection,
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
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
        ),
      ),
    );
  }
}
