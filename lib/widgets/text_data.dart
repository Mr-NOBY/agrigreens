import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TextData extends StatelessWidget {
  final String title;
  final String unit;
  final String value;
  final DateTime time;

  const TextData({
    super.key,
    required this.title,
    required this.value,
    required this.time,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("$title: $value $unit"),
        Text("Time: ${DateFormat.jms().format(time)}"),
      ],
    );
  }
}
