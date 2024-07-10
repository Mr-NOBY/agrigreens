import 'package:flutter/material.dart';

class CustomView extends StatelessWidget {
  final BuildContext context;
  final Widget leftWidget;
  final Widget rightWidget;
  final Widget bottomWidget;

  CustomView(
      {super.key,
      required this.context,
      Widget? leftWidget,
      Widget? rightWidget,
      Widget? bottomWidget})
      : leftWidget = leftWidget ??
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.5,
              width: MediaQuery.of(context).size.width * 0.5,
            ),
        rightWidget = rightWidget ??
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.5,
              width: MediaQuery.of(context).size.width * 0.5,
            ),
        bottomWidget = bottomWidget ??
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.5,
            );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.5,
              width: MediaQuery.of(context).size.width * 0.5,
              child: leftWidget,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.5,
              width: MediaQuery.of(context).size.width * 0.5,
              child: rightWidget,
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.5,
          child: bottomWidget,
        ),
        Divider(
          indent: 20,
          endIndent: 20,
          color: Colors.blueGrey,
        ),
      ],
    );
  }
}
