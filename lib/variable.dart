import 'package:agrigreens/repository/auth_repository/auth_repo.dart';
import 'package:agrigreens/services/google_sheets_service.dart';
import 'package:agrigreens/var_controller.dart';
import 'package:agrigreens/widgets/chart.dart';
import 'package:agrigreens/widgets/custom_view.dart';
import 'package:agrigreens/widgets/gauges.dart';
import 'package:agrigreens/widgets/text_data.dart';
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
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
            // backgroundColor: Themes.maincolorScheme.secondary,
          ),
          drawer: Drawer(child: Column()),
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
                    CustomView(
                      context: context,
                      leftWidget: GetX<VarController>(builder: (context) {
                        return Container(
                          child: Gauge1(
                            title: 'PH',
                            value: controller.PH.value,
                          ),
                        );
                      }),
                      rightWidget: GetX<VarController>(builder: (context) {
                        if (controller.timestamps.isEmpty) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("PH:  [unit]"),
                              Text("Time: "),
                            ],
                          );
                        }
                        return TextData(
                            title: "PH",
                            value: controller.PH.value,
                            time: controller.timestamps.last,
                            unit: "");
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text("PH: ${controller.PH.value} [unit]"),
                        //     Text(
                        //         "Time: ${DateFormat.jms().format(controller.timestamps.last)}"),
                        //   ],
                        // );
                      }),
                      bottomWidget: GetX<VarController>(builder: (context) {
                        if (controller.sensorData.isEmpty) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return Chart(
                          sData: controller.sensorData,
                          time: controller.timestamps,
                        );
                      }),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          AuthRepo.instance.logout();
                        },
                        child: Text('Log out')),
                    ElevatedButton(
                        onPressed: () {
                          sendEmail("eo54872@gmail.com");
                        },
                        child: Text('Send Mail')),
                    ElevatedButton(
                        onPressed: () {
                          downloadCSV();
                        },
                        child: Text('Download CSV')),
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
