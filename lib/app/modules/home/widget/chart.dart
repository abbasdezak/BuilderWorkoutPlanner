import 'package:builderworkoutplanner/app/core/values/app_colors.dart';
import 'package:builderworkoutplanner/app/core/values/theme.dart';
import 'package:builderworkoutplanner/app/modules/home/model/chart_sample_data.dart';
import 'package:builderworkoutplanner/app/modules/home/widget/blue_botton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WorkoutPrevChart extends StatelessWidget {
  WorkoutPrevChart({Key? key, required this.width, required this.height})
      : super(key: key);
  final double width;
  final double height;
  TooltipBehavior _tooltipBehavior = TooltipBehavior(
      enable: true,
      canShowMarker: false,
      format: 'point.x : point.y times',
      header: '');
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(color: AppColors.darkBlue),
      width: width,
      height: height,
      child: Column(children: [
        Text(
          'Chest & back',
          style: titleStyleWhite,
        ),
        Container(
          width: size.width * .9,
          height: size.height * .315,
          child: SfCartesianChart(
            margin: EdgeInsets.only(top: 25, bottom: 10),
            plotAreaBorderWidth: 0,
            enableAxisAnimation: true,
            primaryXAxis: CategoryAxis(
              labelStyle: const TextStyle(color: Colors.white),
              axisLine: const AxisLine(width: 0),
              labelPosition: ChartDataLabelPosition.outside,
              majorTickLines: const MajorTickLines(width: 0),
              majorGridLines: const MajorGridLines(width: 0),
            ),
            primaryYAxis: NumericAxis(isVisible: false, minimum: 0, maximum: 4),
            series: _getRoundedColumnSeries([ChartSampleData(x: 'x', y: 2)]),
            tooltipBehavior: _tooltipBehavior,
          ),
        ),
        SizedBox(
          height: size.height * .017,
        ),
        MyButton(
          text: 'Start',
          onTap: () => null,
          height: size.height * .085,
          width: size.width,
        )
      ]),
    );
  }
}

class HomeChart extends StatelessWidget {
  HomeChart(
      {Key? key,
      required this.title,
      required this.onStart,
      required this.chartsData})
      : super(key: key);
  final String title;
  final List<ChartSampleData> chartsData;
  final Function() onStart;
  TooltipBehavior? _tooltipBehavior = TooltipBehavior(
      enable: true,
      canShowMarker: false,
      format: 'point.x : point.y times',
      header: '');

  double findMax() {
    var x = 0;
    chartsData.forEach((element) {
      if (element.y > x) {
         x = element.y;
      }
    });
    print(x);
    return x.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 0, 37, 77),
                Color.fromARGB(255, 9, 57, 125),
                Color.fromARGB(255, 1, 48, 114),
              ]),
          borderRadius: BorderRadius.circular(4)),
      width: size.width * .9,
      height: size.height * .42,
      child: Column(children: [
        SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: titleStyleWhite,
        ),
        Container(
          width: size.width * .8,
          height: size.height * .29,
          child: SfCartesianChart(
            plotAreaBorderWidth: 0,
            primaryXAxis: CategoryAxis(
              labelStyle: const TextStyle(color: Colors.white),
              axisLine: const AxisLine(width: 0),
              labelPosition: ChartDataLabelPosition.outside,
              majorTickLines: const MajorTickLines(width: 0),
              majorGridLines: const MajorGridLines(width: 0),
            ),
            primaryYAxis:
                NumericAxis(isVisible: false, minimum: 0, maximum: findMax()),
            series: _getRoundedColumnSeries(chartsData),
            tooltipBehavior: _tooltipBehavior,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  '7',
                  style: titleStyleWhite,
                ),
                Text(
                  'times Completed',
                  style: subTitleStyle,
                ),
              ],
            ),
            MyButton(
              text: 'Start',
              onTap: onStart,
              height: size.height * .07,
              width: size.width * .28,
            )
          ],
        )
      ]),
    );
  }
}

List<ColumnSeries<ChartSampleData, String>> _getRoundedColumnSeries(
    chart_sample_data) {
  return <ColumnSeries<ChartSampleData, String>>[
    ColumnSeries<ChartSampleData, String>(
      gradient: LinearGradient(colors: [
        Colors.blue[900]!,
        Colors.blue[800]!,
        Colors.blue[700]!,
      ]),
      width: .9,
      dataLabelSettings: const DataLabelSettings(
          isVisible: true, labelAlignment: ChartDataLabelAlignment.top),
      dataSource: chart_sample_data,

      /// If we set the border radius value for column series,
      /// then the series will appear as rounder corner.
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(3),
        topRight: Radius.circular(3),
      ),
      xValueMapper: (ChartSampleData sales, _) => sales.x,
      yValueMapper: (ChartSampleData sales, _) => sales.y,
    ),
  ];
}
