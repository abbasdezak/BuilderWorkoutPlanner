import 'package:builderworkoutplanner/app/core/model/time_helper.dart';
import 'package:builderworkoutplanner/app/data/local/preference/prefs.dart';
import 'package:builderworkoutplanner/app/modules/home/model/chart_sample_data.dart';
import 'package:get/get.dart';

class StatsController extends GetxController {
  var workoutDates = <ChartSampleData>[].obs;
  @override
  void onInit() {
    getWorkoutWeightsPerDay();
    super.onInit();
  }
  getWorkoutWeightsPerDay() async {
    var data = await Prefs().getWorkoutDetails();

    List<DateTime> dates = [];
    data.events!.forEach((e) {
      e.dateTime!.forEach((element) {
        dates.add(element);
      });
    });
    workoutDates(TimeHelper().statsChartSamples(dates: dates));
  }
}
