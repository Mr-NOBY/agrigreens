import 'package:agrigreens/var_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Gauge1 extends StatelessWidget {
  final VarController controller;
  const Gauge1({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.5,
      width: MediaQuery.of(context).size.width * 0.5,
      child: GetX<VarController>(builder: (context) {
        return SfRadialGauge(
            title: GaugeTitle(
                text: 'Temp',
                textStyle: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold)),
            axes: <RadialAxis>[
              RadialAxis(minimum: 0, maximum: 150, ranges: <GaugeRange>[
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
              ], pointers: <GaugePointer>[
                NeedlePointer(value: double.parse(controller.temp.value))
              ], annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    widget: Container(
                        child: Text(controller.temp.value,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold))),
                    angle: 90,
                    positionFactor: 0.5)
              ])
            ]);
      }),
    );
  }
}
