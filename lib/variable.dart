import 'package:agrigreens/repository/auth_repository/auth_repo.dart';
import 'package:agrigreens/services/google_sheets_service.dart';
import 'package:agrigreens/var_controller.dart';
import 'package:agrigreens/widgets/custom_row.dart';
import 'package:agrigreens/widgets/gauges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agrigreens/global/app_themes.dart';
import 'package:agrigreens/global/client.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
                    CustomRow(
                      context: context,
                      leftWidget: GetX<VarController>(builder: (context) {
                        return Gauge1(
                          title: 'Temp',
                          value: controller.temp.value,
                        );
                      }),
                      rightWidget: GetX<VarController>(builder: (context) {
                        return Gauge1(
                          title: 'PH',
                          value: controller.PH.value,
                        );
                      }),
                    ),
                    Obx(() {
                      if (controller.sensorData.isEmpty) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return SfCartesianChart(
                        plotAreaBorderWidth: 0,
                        primaryXAxis: DateTimeAxis(
                          majorGridLines: const MajorGridLines(width: 0),
                          dateFormat: DateFormat.Hms(),
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
                        tooltipBehavior:
                            TooltipBehavior(enable: true, header: 'PH'),
                        series: <CartesianSeries>[
                          SplineSeries<double, DateTime>(
                            enableTooltip: true,
                            animationDuration: 0,
                            dataSource: controller.sensorData,
                            xValueMapper: (double data, int index) =>
                                controller.timestamps[index],
                            yValueMapper: (double data, _) => data,
                            markerSettings: MarkerSettings(isVisible: true),
                          )
                        ],
                      );
                    }),
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
