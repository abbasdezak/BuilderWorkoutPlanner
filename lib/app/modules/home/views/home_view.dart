import 'package:builderworkoutplanner/app/core/base/core_controller.dart';
import 'package:builderworkoutplanner/app/core/model/exercise_model.dart';
import 'package:builderworkoutplanner/app/modules/home/views/plan_prev.dart';
import 'package:builderworkoutplanner/app/modules/home/views/show_all.dart';
import 'package:builderworkoutplanner/app/modules/home/widget/chart.dart';
import 'package:builderworkoutplanner/app/modules/statics/controllers/stats_controller.dart';
import 'package:builderworkoutplanner/app/modules/workout_page/views/workout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:builderworkoutplanner/app/core/values/theme.dart';
import 'package:builderworkoutplanner/app/modules/add_new_workout_plan/views/add_exercise_page.dart';
import 'package:builderworkoutplanner/app/modules/home/widget/blue_botton.dart';
import 'package:intl/intl.dart';

class HomeView extends StatelessWidget {
  CoreController _controller = Get.put(CoreController());
  StatsController _statsController = Get.put(StatsController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          leadingWidth: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Dashboard',
            style: bigTitleStyle,
          ),
          actions: [
            Container(
                margin: EdgeInsets.only(right: size.width * .05),
                child: Icon(
                  Icons.person_outline_outlined,
                  color: Colors.black,
                  size: size.width * .08,
                )),
          ]),
      body: Column(children: [
        Container(
          height: size.height * .14,
          width: size.width,
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.grey[300]!, width: 1)),
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _detailsCardView(size, _statsController.workoutCompleted,
                    'workouts\ncompleted'),
                _detailsCardView(size, '${_statsController.tonnageLifted} KG',
                    'weight\nlifted'),
                _detailsCardView(
                    size, '${_statsController.weightKg} KG', 'current\nweight'),
              ],
            ),
          ),
        ),
        _widgets(size)
      ]),
    );
  }

  _prevWorkout(Size size) {
    return GestureDetector(
      onTap: () => Get.to(
          () => Workout(workoutName: _statsController.lastWorkout.value.id!)),
      child: Container(
        height: size.height * .14,
        width: size.width,
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.grey[300]!, width: 1)),
        child: Row(
          children: [
            Container(
              height: size.height * .09,
              width: size.width * .15,
              decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.circular(4)),
              padding: EdgeInsets.all(size.height * .015),
              margin: EdgeInsets.all(size.height * .019),
              child: Column(
                children: [
                  Text(
                    '${_statsController.lastWorkout.value.dateTime!.last.day}',
                    style: titleStyleWhite,
                  ),
                  Text(
                    '${DateFormat.MMM().format((_statsController.lastWorkout.value.dateTime!.last))}',
                    style: smalSubTitleStyleWhite,
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Previous Workout",
                    style: subTitleStyleGrey,
                  ),
                  Text(
                    "${AllPlans().nameEncoder(_statsController.lastWorkout.value.id!).toUpperCase()}",
                    style: titleStyle,
                  ),
                  Text(
                    "${_statsController.lastWorkout.value.exercisesRepetations} times completed",
                    style: smalSubTitleStyle,
                  ),
                ],
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.grey,
              size: 20,
            ),
            SizedBox(
              width: 15,
            )
          ],
        ),
      ),
    );
  }

  Container _detailsCardView(Size size, title, subtitle) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 15),
      width: size.width * .33,
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey[200]!, width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title',
            style: bigTitleStyle,
          ),
          Text(
            subtitle,
            style: smallTitleStyleGrey,
          ),
        ],
      ),
    );
  }

  Widget _widgets(Size size) {
    return Obx(() {
      return _controller.plans.length == 0
          ? Expanded(
              child: Column(
              children: [
                Container(
                  width: size.width * .8,
                  margin: EdgeInsets.only(top: 15, bottom: 10),
                  child: Image.asset(
                    "assets/images/empty.jpg",
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  'You have no workouts yet. Go on and create\nyour first one!',
                  textAlign: TextAlign.center,
                  style: subTitleStyleGrey,
                ),
                SizedBox(
                  height: 25,
                ),
                MyButton(
                  text: 'Create Workout',
                  onTap: () => Get.to(() => AddExercise()),
                  width: size.width * .5,
                )
              ],
            ))
          : Column(
              children: [
                _prevWorkout(size),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * .06,
                      vertical: size.height * .02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'MY WORKOUTS',
                        style: subTitleStyleGrey,
                      ),
                      GestureDetector(
                        onTap: () => Get.to(() => ShowAll()),
                        child: Text('Show All', style: smallTitleStyleBlue),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.to(PlanPreview()),
                  child: HomeChart(
                      chartsData:
                          _controller.showCharts(_controller.plans[0].planName),
                      title: AllPlans().nameEncoder(
                          _controller.plans[0].planName.toString()),
                      onStart: () {
                        Get.to(Workout(
                          workoutName: _controller.plans[0].planName.toString(),
                        ));
                      }),
                ),
              ],
            );
    });
  }
}
