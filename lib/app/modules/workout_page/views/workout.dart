import 'package:builderworkoutplanner/app/core/base/core_controller.dart';
import 'package:builderworkoutplanner/app/modules/workout_page/controllers/workout_controller.dart';
import 'package:builderworkoutplanner/app/modules/workout_page/views/congrat_page.dart';
import 'package:builderworkoutplanner/app/modules/workout_page/views/rest_page.dart';
import 'package:builderworkoutplanner/app/modules/workout_page/views/workout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class Workout extends StatelessWidget {
  Workout({Key? key, required this.workoutName}) : super(key: key);
  CoreController _controller = Get.put(CoreController());
  final String workoutName;

  @override
  Widget build(BuildContext context) {
    return GetX<WorkoutController>(
        init: WorkoutController(), 
        builder: (state) {
          if (state.pageStatus == PageState.workout) {
            return WorkoutPage(
              workoutName: workoutName,
            );
          } else if (state.currIndex < state.totalIndex.toInt()) {
            return RestPage(
              workoutName: workoutName,
            );
          } else {
            return CongratPage(
              workoutName: workoutName,
            );
          }
        });
  }
}
