import 'package:agrigreens/repository/auth_repository/auth_repo.dart';
import 'package:agrigreens/var_controller.dart';
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
                    GetX<VarController>(builder: (context) {
                      return Text(
                        controller.PH.value,
                      );
                    }),
                    GetX<VarController>(builder: (context) {
                      return Text(
                        controller.temp.value,
                      );
                    }),
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
