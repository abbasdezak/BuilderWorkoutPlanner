import 'package:builderworkoutplanner/app/core/model/events.dart';
import 'package:builderworkoutplanner/app/core/model/exercise_model.dart';
import 'package:builderworkoutplanner/app/core/model/time_helper.dart';
import 'package:builderworkoutplanner/app/data/local/preference/prefs.dart';
import 'package:builderworkoutplanner/app/modules/home/model/chart_sample_data.dart';
import 'package:get/get.dart';

class CoreController extends GetxController {
  final plans = <Plan>[].obs;
  var chartSamples = <Event>[].obs;

  @override
  void onInit() {
    super.onInit();
     getAllcharts();
  }

  // @override
  // void onClose() {
  //   // plans.close();
  //   super.onClose();
  // }

  List<ChartSampleData> statiisticsChart() {
    List<DateTime> listTime = [];
    chartSamples.forEach((e) {
      e.dateTime!.forEach((element) {
        listTime.add(element);
      });
    });
    try {
      return TimeHelper().workoutChaetSamlpes(dates: listTime);
    } catch (e) {
      // print(e);
      return TimeHelper().workoutChaetSamlpes();
    }
  }

  List<ChartSampleData> showCharts(details) {
    try {
      print('${chartSamples[1].exercisesRepetations}');
      return TimeHelper().workoutChaetSamlpes(
          dates: chartSamples
              .firstWhere(
                  (element) => element.id == Events().idGenerator(details))
              .dateTime as List<DateTime>);
    } catch (e) {
      // print(e);
      return TimeHelper().workoutChaetSamlpes();
    }
  }

  void getAllcharts() async {
    try {
      var getPlans = await Prefs().getData();
      plans.assignAll(getPlans.plans!.map((e) => e));
      Events allEvents = await Prefs().getWorkoutDetails();
      chartSamples.assignAll(allEvents.events!);
      chartSamples.refresh();
    } catch (e) {
      print(e);
    }
  }

  deleteExercise(index) async {
    await Prefs().deleteData(index: index);
    plans.refresh();
  }

  // makeChartSample(id) async {
  //   print(chartSamples);
  //   if (chartSamples.isNotEmpty) {
  //     chartSample(TimeHelper().chartSamples(chartSamples
  //         .firstWhere(
  //             (element) => element.id == Events().idGenerator(plans[id]))
  //         .dateTime as List<DateTime>));
  //   }
  // }
}
