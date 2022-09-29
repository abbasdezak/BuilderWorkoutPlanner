import 'dart:async';
import 'package:builderworkoutplanner/app/core/base/core_controller.dart';
import 'package:builderworkoutplanner/app/core/model/events.dart';
import 'package:builderworkoutplanner/app/core/model/exercise_model.dart';
import 'package:builderworkoutplanner/app/data/local/preference/prefs.dart';
import 'package:builderworkoutplanner/app/modules/statics/controllers/stats_controller.dart';
import 'package:get/get.dart';

enum PageState { workout, rest, ending }

class WorkoutController extends GetxController {
  CoreController _controller = Get.put(CoreController());
  StatsController _statsController = Get.put(StatsController());
  var pageStatus = PageState.workout.obs;
  var currIndex = 0.obs;
  var totalIndex = 0.obs;
  static const maxSeconds = 30;
  static const duration = 1;
  var seconds = maxSeconds.obs;
  Timer? timer;
  @override
  void onInit() {
    super.onInit();
  }

  void reset() {
    seconds(maxSeconds);
    timer?.cancel();
    update();
  }

  void pause() {
    timer?.cancel();
    update();
  }

  void startTimer() {
    timer =
        new Timer.periodic(const Duration(seconds: duration), (Timer timer) {
      if (seconds == 0) {
        pageStatus(PageState.workout);
        reset();
      } else {
        seconds--;
        update();
      }
    });
  }

  void saveWorkoutDetails({required Plan details}) async {
    int weight = 0;
    details.exercises!.forEach((e) {
      e.sets!.forEach((element) {
        weight += int.parse(element.weight!);
      });
    });
    await Prefs().saveWorkoutDetails(
        dateTime: DateTime.now(), id: details.planName, weight: weight);
   _controller.getAllcharts();
  _statsController.initData();
  }
}
