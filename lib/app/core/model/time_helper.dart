import 'package:builderworkoutplanner/app/modules/home/model/chart_sample_data.dart';

class TimeHelper {
  List<ChartSampleData> workoutChaetSamlpes({List<DateTime>? dates}) {
    return [
      ChartSampleData(
          x: 'Sat', y: dates?.where((date) => date.weekday == 6).length ?? 0),
      ChartSampleData(
          x: 'Sun', y: dates?.where((date) => date.weekday == 7).length ?? 0),
      ChartSampleData(
          x: 'Mon', y: dates?.where((date) => date.weekday == 1).length ?? 0),
      ChartSampleData(
          x: 'Tue', y: dates?.where((date) => date.weekday == 2).length ?? 0),
      ChartSampleData(
          x: 'Wed', y: dates?.where((date) => date.weekday == 3).length ?? 0),
      ChartSampleData(
          x: 'Thu', y: dates?.where((date) => date.weekday == 4).length ?? 0),
      ChartSampleData(
          x: 'Fri', y: dates?.where((date) => date.weekday == 5).length ?? 0),
    ];
  }
  List<ChartSampleData> statsChartSamples({List<DateTime>? dates}) {
    return [
      ChartSampleData(
          x: 'Sat', y: dates?.where((date) => date.weekday == 6).length ?? 0),
      ChartSampleData(
          x: 'Sun', y: dates?.where((date) => date.weekday == 7).length ?? 0),
      ChartSampleData(
          x: 'Mon', y: dates?.where((date) => date.weekday == 1).length ?? 0),
      ChartSampleData(
          x: 'Tue', y: dates?.where((date) => date.weekday == 2).length ?? 0),
      ChartSampleData(
          x: 'Wed', y: dates?.where((date) => date.weekday == 3).length ?? 0),
      ChartSampleData(
          x: 'Thu', y: dates?.where((date) => date.weekday == 4).length ?? 0),
      ChartSampleData(
          x: 'Fri', y: dates?.where((date) => date.weekday == 5).length ?? 0),
    ];
  }

  static Map<String, int> workoutsCounter(List datesData) {
    var firstDay = DateTime.now().weekday + 1;
    if (firstDay == 8) {
      firstDay = 7;
    }

    DateTime startWeek = DateTime.now().subtract(Duration(days: firstDay));

    // print(startWeek);

    var startMonth = DateTime(DateTime.now().year, DateTime.now().month);

    List<DateTime> listOfWeek = [];
    List<DateTime> listMonth = [];

    datesData.forEach((e) {
      if (e.isAfter(startWeek)) {
        listOfWeek.add(e);
        print(listOfWeek);
      }
      if (e.isAfter(startMonth)) {
        listMonth.add(e);
        print(listMonth);
      }
    });
    return {'Month': listMonth.length, 'Week': listOfWeek.length};
  }
}
