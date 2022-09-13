import 'package:builderworkoutplanner/app/core/base/core_controller.dart';
import 'package:builderworkoutplanner/app/core/model/events.dart';
import 'package:builderworkoutplanner/app/core/model/time_helper.dart';
import 'package:builderworkoutplanner/app/core/values/app_colors.dart';
import 'package:builderworkoutplanner/app/core/values/theme.dart';
import 'package:builderworkoutplanner/app/modules/add_new_workout_plan/views/add_exercise_page.dart';
import 'package:builderworkoutplanner/app/modules/home/model/chart_sample_data.dart';
import 'package:builderworkoutplanner/app/modules/home/widget/chart.dart';
import 'package:builderworkoutplanner/app/modules/workout_page/views/workout.dart';
import 'package:builderworkoutplanner/app/modules/workout_page/views/workout_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowAll extends StatelessWidget {
  ShowAll({Key? key}) : super(key: key);
  CoreController _controller = Get.put(CoreController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20, top: 15, bottom: 20),
            child: Text(
              'My Workouts',
              style: headerTitleStyle,
            ),
          ),
          Expanded(child: Obx(() {
            return ListView.builder(
                itemCount: _controller.plans.length,
                itemBuilder: (_, index) {
                  return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: HomeChart(
                        chartsData: _controller.showCharts(_controller.plans[index]),
                        onStart: () {
                          Get.to(Workout(workoutIndex: index,));
                        },
                        title: '${_controller.plans[index].planName}',
                      ));
                });
          }))
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.Blue7,
          size: 20,
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () {
            Get.to(() => AddExercise());
          },
          icon: Icon(
            Icons.add_rounded,
            color: AppColors.Blue7,
          ),
        )
      ],
    );
  }
}
