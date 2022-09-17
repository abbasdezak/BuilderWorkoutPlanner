import 'package:builderworkoutplanner/app/core/base/core_controller.dart';
import 'package:builderworkoutplanner/app/core/values/theme.dart';
import 'package:builderworkoutplanner/app/modules/workout_page/controllers/workout_controller.dart';
import 'package:builderworkoutplanner/app/modules/workout_page/views/rest_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/model/exercise_model.dart';

class WorkoutPage extends StatelessWidget {
  CoreController _controller = Get.put(CoreController());
  WorkoutController _state = Get.put(WorkoutController());
  final String workoutName;
  WorkoutPage({
    Key? key,
    required this.workoutName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(body: widgets(size, context));
  }

  widgets(Size size, BuildContext context) {
    return Obx(() {
      Plan plan = _controller.plans.value
          .firstWhere((element) => element.planName == workoutName);
      if (_state.totalIndex == 0) {
        _state.totalIndex(plan.exercises!.length);
      }
      var workoutContents = plan.exercises;
      int currentExercise = _state.currIndex.toInt();
      var linearValue = (currentExercise + 1) / workoutContents!.length;
      bool checkSetLenght = workoutContents[currentExercise].sets!.length >= 2;
      return Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: size.height * .026,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      margin: EdgeInsets.all(15),
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          onPressed: () {
                            if (_state.currIndex == 0) {
                              Get.back();
                            } else {
                              _state.currIndex--;
                            }
                          },
                          icon: Icon(Icons.arrow_back_ios))),
                  Container(
                    margin: EdgeInsets.all(15),
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () {
                          _state.pageStatus(PageState.rest);
                          _state.reset();
                          _state.currIndex(_state.currIndex.toInt() + 1);
                        }

                        // showDiolog(context, workoutContents);
                        ,
                        icon: Icon(Icons.arrow_forward_ios_rounded)),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: size.width * .6,
                    child: Text('${workoutContents[currentExercise].name}',
                        style: TextStyle(
                          fontSize: size.height * .02,
                        ),),
                  ),
                  Text('${currentExercise + 1}/${workoutContents.length}',
                      style: TextStyle(
                          fontSize: size.height * .028,)),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                width: size.width * .835,
                height: size.height * 0.025,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.blue[50]!,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.blue[400]!,
                    ),
                    value: linearValue,
                  ),
                ),
              ),
              Container(
                width: size.width * .9,
                alignment: Alignment.center,
                child: CachedNetworkImage(
                  imageUrl: '${workoutContents[currentExercise].imgurl}',
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              )
            ],
          ),
          Positioned(
            bottom: size.height * 0.05,
            right: size.height * .05,
            left: size.height * .05,
            child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.blue.withOpacity(0.07),
                ),
                height:
                    (checkSetLenght) ? size.height * .27 : size.height * .17,
                child: ListView.builder(
                    itemCount: workoutContents[currentExercise].sets!.length,
                    itemBuilder: (_, index) {
                      return Container(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 20),
                        child: buildText(
                            title: (index + 1).toString(),
                            reps: workoutContents[currentExercise]
                                .sets![index]
                                .reps
                                .toString(),
                            weights: workoutContents[currentExercise]
                                .sets![index]
                                .weight
                                .toString()),
                      );
                    })),
          )
        ],
      );
    });
  }

  Widget buildText({
    required String title,
    required String reps,
    required String weights,
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                'Set',
                style: smallTitleStyleGrey,
              ),
              SizedBox(height: 8),
              Text(
                title,
                style: titleStyle,
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'Reps',
                style: smallTitleStyleGrey,
              ),
              SizedBox(height: 12),
              Text(
                '$reps',
                style: titleStyle,
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'Weight',
                style: smallTitleStyleGrey,
              ),
              SizedBox(height: 8),
              Text(
                '$weights kg',
                style: titleStyle,
              ),
            ],
          ),
        ],
      );
}
