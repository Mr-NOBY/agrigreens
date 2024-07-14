import 'package:agrigreens/var_controller.dart';
import 'package:agrigreens/widgets/chart.dart';
import 'package:agrigreens/widgets/custom_view.dart';
import 'package:agrigreens/widgets/drawer.dart';
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
          drawer: const CustomDrawer(),
          body: RefreshIndicator(
            onRefresh: _refreshConnection,
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GetX<VarController>(
                      builder: (controller) {
                        return CustomView(
                          context: context,
                          leftWidget: Container(
                            child: Gauge1(
                              title: 'PH',
                              value: controller.reading.value,
                            ),
                          ),
                          rightWidget: controller.timestamps.isEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("PH:  [unit]"),
                                    Text("Time: "),
                                  ],
                                )
                              : TextData(
                                  title: "PH",
                                  value: controller.reading.value,
                                  time: controller.timestamps.last,
                                  unit: "",
                                ),
                          bottomWidget: controller.sensorData.isEmpty
                              ? Center(child: CircularProgressIndicator())
                              : Chart(
                                  sData: controller.sensorData,
                                  time: controller.timestamps,
                                ),
                        );
                      },
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
