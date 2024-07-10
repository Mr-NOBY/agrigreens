import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatelessWidget {
  final List<double> sData;
  final List<DateTime> time;

  const Chart({
    super.key,
    required this.sData,
    required this.time,
  });
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: DateTimeAxis(
        majorGridLines: const MajorGridLines(width: 0),
        dateFormat: DateFormat.jm(),
        intervalType: DateTimeIntervalType.minutes,
        autoScrollingDelta: 60,
        autoScrollingDeltaType: DateTimeIntervalType.seconds,
      ),
      primaryYAxis: const NumericAxis(
        axisLine: AxisLine(width: 0),
        majorTickLines: MajorTickLines(size: 0),
      ),
      zoomPanBehavior: ZoomPanBehavior(
        enablePanning: true,
        enablePinching: true,
        zoomMode: ZoomMode.x,
      ),
      tooltipBehavior: TooltipBehavior(enable: true, header: 'PH'),
      series: <CartesianSeries>[
        SplineSeries<double, DateTime>(
          enableTooltip: true,
          animationDuration: 0,
          dataSource: sData, //controller.sensorData,
          xValueMapper: (double data, int index) => time[index],
          yValueMapper: (double data, _) => data,
          markerSettings: MarkerSettings(isVisible: true),
        )
      ],
    );
  }
}
