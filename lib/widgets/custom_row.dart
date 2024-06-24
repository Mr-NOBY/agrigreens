import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  final BuildContext context;
  final Widget leftWidget;
  final Widget rightWidget;

  CustomRow(
      {super.key,
      required this.context,
      Widget? leftWidget,
      Widget? rightWidget})
      : leftWidget = leftWidget ??
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.5,
              width: MediaQuery.of(context).size.width * 0.5,
            ),
        rightWidget = rightWidget ??
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.5,
              width: MediaQuery.of(context).size.width * 0.5,
            );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        leftWidget,
        rightWidget,
      ],
    );
  }
}
