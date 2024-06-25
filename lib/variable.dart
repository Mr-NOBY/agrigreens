import 'package:agrigreens/repository/auth_repository/auth_repo.dart';
import 'package:agrigreens/var_controller.dart';
import 'package:agrigreens/widgets/custom_row.dart';
import 'package:agrigreens/widgets/gauges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agrigreens/global/app_themes.dart';
import 'package:agrigreens/global/client.dart';

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
            centerTitle: true,
            // backgroundColor: Themes.maincolorScheme.secondary,
          ),
          body: RefreshIndicator(
            onRefresh: _refreshConnection,
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomRow(
                      context: context,
                      leftWidget: GetX<VarController>(builder: (context) {
                        return Gauge1(
                          title: 'Temp',
                          value: controller.temp.value,
                        );
                      }),
                      rightWidget: GetX<VarController>(builder: (context) {
                        return Gauge1(
                          title: 'PH',
                          value: controller.PH.value,
                        );
                      }),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          AuthRepo.instance.logout();
                        },
                        child: Text('Log out')),
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
