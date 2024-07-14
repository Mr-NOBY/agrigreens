import 'package:flutter/material.dart';

class Metric extends StatelessWidget {
  final String title;
  final String unit;
  final List<double> sensorReadings;
  final List<DateTime> timeStamps;

  const Metric(
      {super.key,
      required this.title,
      required this.unit,
      required this.sensorReadings,
      required this.timeStamps});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
