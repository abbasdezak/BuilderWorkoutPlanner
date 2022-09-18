import 'package:builderworkoutplanner/app/modules/home/model/chart_sample_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controllers/stats_controller.dart';

class StatsChart extends StatelessWidget {
  StatsChart();
  StatsController _stats = Get.put(StatsController());

  double findMax() {
    var x = 0;
    _stats.workoutDates.forEach((element) {
      if (element.y > x) {
        x = element.y;
      }
    });
    print(x);
    return x.toDouble();
  }

  List<String>? _splineList =
      <String>['natural', 'monotonic', 'cardinal', 'clamped'].toList();
  String _selectedSplineType = 'monotonic';
  SplineType? _spline = SplineType.monotonic;
  TooltipBehavior? _tooltipBehavior = TooltipBehavior(
      enable: true,
      canShowMarker: false,
      format: 'point.x : point.y times',
      header: '');
  // TooltipBehavior(enable: true, header: '', canShowMarker: false);

  @override
  Widget build(BuildContext context) {
    return _buildTypesSplineChart(context);
  }

  @override
  Widget buildSettings(BuildContext context) {
    return Obx(
      () => Row(
        children: <Widget>[
          Text('Spline type ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              )),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            height: 50,
            alignment: Alignment.bottomLeft,
            child: DropdownButton<String>(
                focusColor: Colors.transparent,
                underline: Container(color: const Color(0xFFBDBDBD), height: 1),
                value: _selectedSplineType,
                items: _splineList!.map((String value) {
                  return DropdownMenuItem<String>(
                      value: (value != null) ? value : 'natural',
                      child:
                          Text(value, style: TextStyle(color: Colors.black)));
                }).toList(),
                onChanged: (dynamic value) {
                  _onPositionTypeChange(value.toString());
                  // stateSetter(() {});
                }),
          ),
        ],
      ),
    );
  }

  /// Returns the spline types chart.
  _buildTypesSplineChart(_) {
    var size = MediaQuery.of(_).size;
    return Container(
      padding: EdgeInsets.only(
        right: size.width * .06,
        left: size.width * .01,
      ),
      child: SfCartesianChart(
        plotAreaBorderWidth: 1,
        title: ChartTitle(text: 'Stats'),
        primaryXAxis: CategoryAxis(
          labelStyle: const TextStyle(color: Colors.black),
          axisLine: const AxisLine(width: 0),
          labelPosition: ChartDataLabelPosition.outside,
          majorTickLines: const MajorTickLines(width: 1),
          majorGridLines: const MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
            isVisible: true,
            labelFormat: '{value}',
            minimum: 0,
            maximum: findMax(),
            majorTickLines: const MajorTickLines(size: 0)),
        series: _getSplineTypesSeries(),
        tooltipBehavior: _tooltipBehavior,
      ),
    );
  }

  /// Returns the list of chart series which need to render on the spline chart.
  List<SplineSeries<ChartSampleData, String>> _getSplineTypesSeries() {
    return <SplineSeries<ChartSampleData, String>>[
      SplineSeries<ChartSampleData, String>(

          /// To set the spline type here.
          splineType: _spline,
          dataSource: _stats.workoutDates,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          width: 2)
    ];
  }

  /// Method to change the spline type using dropdown menu.
  void _onPositionTypeChange(String item) {
    _selectedSplineType = item;
    if (_selectedSplineType == 'natural') {
      _spline = SplineType.natural;
    }
    if (_selectedSplineType == 'monotonic') {
      _spline = SplineType.monotonic;
    }
    if (_selectedSplineType == 'cardinal') {
      _spline = SplineType.cardinal;
    }
    if (_selectedSplineType == 'clamped') {
      _spline = SplineType.clamped;
    }
    // setState(() {
    //   /// update the spline type changes
    // });
  }
}

/// Private class for storing the spline series data points.

