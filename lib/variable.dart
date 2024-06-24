import 'package:agrigreens/repository/auth_repository/auth_repo.dart';
import 'package:agrigreens/var_controller.dart';
import 'package:agrigreens/widgets/custom_row.dart';
import 'package:agrigreens/widgets/gauges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agrigreens/global/app_themes.dart';
import 'package:agrigreens/global/client.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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
                    Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 0.5,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: GetX<VarController>(builder: (context) {
                            return SfRadialGauge(
                                title: GaugeTitle(
                                    text: 'PH',
                                    textStyle: const TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                                axes: <RadialAxis>[
                                  RadialAxis(
                                      minimum: 0,
                                      maximum: 150,
                                      ranges: <GaugeRange>[
                                        GaugeRange(
                                            startValue: 0,
                                            endValue: 50,
                                            color: Colors.green,
                                            startWidth: 10,
                                            endWidth: 10),
                                        GaugeRange(
                                            startValue: 50,
                                            endValue: 100,
                                            color: Colors.orange,
                                            startWidth: 10,
                                            endWidth: 10),
                                        GaugeRange(
                                            startValue: 100,
                                            endValue: 150,
                                            color: Colors.red,
                                            startWidth: 10,
                                            endWidth: 10)
                                      ],
                                      pointers: <GaugePointer>[
                                        NeedlePointer(
                                            value: double.parse(
                                                controller.PH.value))
                                      ],
                                      annotations: <GaugeAnnotation>[
                                        GaugeAnnotation(
                                            widget: Container(
                                                child: Text(controller.PH.value,
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                            angle: 90,
                                            positionFactor: 0.5)
                                      ])
                                ]);
                          }),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.width * 0.5,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: GetX<VarController>(builder: (context) {
                            return SfRadialGauge(
                                title: GaugeTitle(
                                    text: 'Temp',
                                    textStyle: const TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                                axes: <RadialAxis>[
                                  RadialAxis(
                                      minimum: 0,
                                      maximum: 150,
                                      ranges: <GaugeRange>[
                                        GaugeRange(
                                            startValue: 0,
                                            endValue: 50,
                                            color: Colors.green,
                                            startWidth: 10,
                                            endWidth: 10),
                                        GaugeRange(
                                            startValue: 50,
                                            endValue: 100,
                                            color: Colors.orange,
                                            startWidth: 10,
                                            endWidth: 10),
                                        GaugeRange(
                                            startValue: 100,
                                            endValue: 150,
                                            color: Colors.red,
                                            startWidth: 10,
                                            endWidth: 10)
                                      ],
                                      pointers: <GaugePointer>[
                                        NeedlePointer(
                                            value: double.parse(
                                                controller.temp.value))
                                      ],
                                      annotations: <GaugeAnnotation>[
                                        GaugeAnnotation(
                                            widget: Container(
                                                child: Text(
                                                    controller.temp.value,
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                            angle: 90,
                                            positionFactor: 0.5)
                                      ])
                                ]);
                            // Text(
                            //   controller.temp.value,
                            // );
                          }),
                        ),
                      ],
                    ),
                    CustomRow(
                        context: context,
                        leftWidget: Gauge1(controller: controller)
                        // rightWidget: Text("Right"),
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
