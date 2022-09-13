import 'package:builderworkoutplanner/app/core/base/core_controller.dart';
import 'package:builderworkoutplanner/app/modules/home/views/plan_prev.dart';
import 'package:builderworkoutplanner/app/modules/home/views/show_all.dart';
import 'package:builderworkoutplanner/app/modules/home/widget/chart.dart';
import 'package:builderworkoutplanner/app/modules/workout_page/views/workout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:builderworkoutplanner/app/core/values/theme.dart';
import 'package:builderworkoutplanner/app/modules/add_new_workout_plan/views/add_exercise_page.dart';
import 'package:builderworkoutplanner/app/modules/home/widget/blue_botton.dart';

class HomeView extends StatelessWidget {
  CoreController _controller = Get.put(CoreController());
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
                margin: EdgeInsets.only(right: size.width*.05),
                child: Icon(
                  Icons.person_outline_outlined,
                  color: Colors.black,
                  size: size.width*.08,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _detailsCardView(size, '0', 'workouts\ncompleted'),
              _detailsCardView(size, '0', 'tonnage\nlifted'),
              _detailsCardView(size, '0 kg', 'current\nweight'),
            ],
          ),
        ),
        _widgets(size)
      ]),
    );
  }

  Container _prevWorkout(Size size) {
    return Container(
      height: size.height * .14,
      width: size.width,
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.grey[300]!, width: 1)),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.blue[800],
                borderRadius: BorderRadius.circular(4)),
            padding: EdgeInsets.all(14),
            margin: EdgeInsets.all(14),
            child: Column(
              children: [
                Text(
                  '22',
                  style: titleStyleWhite,
                ),
                Text(
                  'MAY',
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
                  "Quads & Deltoids",
                  style: titleStyle,
                ),
                Text(
                  "7 exercises completed",
                  style: smalSubTitleStyle,
                ),
              ],
            ),
          ),
          Spacer(),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey,
                size: 15,
              ))
        ],
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
                      chartsData: _controller.showCharts(_controller.plans[0]),
                      title: _controller.plans[0].planName.toString(),
                      onStart: () {
                        Get.to(Workout(
                          workoutIndex: 0,
                        ));
                      }),
                ),
              ],
            );
    });
  }
}
