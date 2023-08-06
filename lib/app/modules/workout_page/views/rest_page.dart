import 'dart:async';

import 'package:builderworkoutplanner/app/core/base/core_controller.dart';
import 'package:builderworkoutplanner/app/core/model/time_helper.dart';
import 'package:builderworkoutplanner/app/core/values/theme.dart';
import 'package:builderworkoutplanner/app/modules/workout_page/controllers/workout_controller.dart';
import 'package:builderworkoutplanner/app/my_app.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/model/exercise_model.dart';

class RestPage extends StatefulWidget {
  final String workoutName;
  RestPage({
    Key? key, required this.workoutName,
  }) : super(key: key);

  @override
  _RestPageState createState() => _RestPageState();
}

class _RestPageState extends State<RestPage> with WidgetsBindingObserver {
  WorkoutController _state = Get.put(WorkoutController());
  CoreController _controller = Get.put(CoreController());
  Plan? plan;
  
  FlareActor _flareActor = FlareActor(
    'assets/circle.flr',
    animation: 'Alarm',
    color: Colors.blue,
  );

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    _state.startTimer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        _state.pause();
        print('paused');
        break;
      case AppLifecycleState.resumed:
        print('resumed');
        _state.startTimer();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.detached:
        // TODO: Handle this case.
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(body: Obx(() {
      plan = _controller.plans.value
            .firstWhere((element) => element.planName == widget.workoutName);
     
      var nextName = plan!
              .exercises![_state.currIndex.toInt()].name
              .toString(),
          _currIndex = _state.currIndex.toInt() + 1;
      var totalIndex = _state.totalIndex.toInt();
      double linearValue = (_currIndex) / totalIndex;
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
                          onPressed: () async {
                            _state.currIndex(_state.currIndex.toInt() - 1);
                            _state.reset();
                            _state.pageStatus(PageState.workout);
                          },
                          icon: Icon(Icons.arrow_back_ios))),
                  Container(
                      margin: EdgeInsets.all(15),
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            _state.seconds(_state.seconds.toInt() + 10);
                          },
                          icon: Icon(Icons.add_rounded))),
                ],
              ),
              Container(
                width: size.width * .8,
                child: Stack(
                  children: [
                    Container(
                      width: size.width*.6,
                      child: Text('Next : ${nextName}',
                          style: subTitleStyleGrey),
                    ),
                    Positioned(
                      right: 0,
                      child: Text('${_currIndex}/${totalIndex}',
                          style: TextStyle(
                              fontSize: size.height * .024,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * .025,
              ),
              Container(
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
              SizedBox(
                height: size.height * 0.07,
              ),
              Container(
                  width: size.height * .4,
                  height: size.height * .4,
                  child: Stack(
                    children: [
                      Center(child: _flareActor),
                      Center(
                          child: Text(
                        'Relax',
                        style: TextStyle(
                            fontSize: size.height * .038, color: Colors.white),
                      ))
                    ],
                  )),
              SizedBox(
                height: 45,
              ),
              Center(
                child: Text(
                  '${_state.seconds}',
                  style: TextStyle(
                      fontSize: size.height * .025,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                  'Seconds left',
                  style: TextStyle(
                      fontSize: size.height * .030, color: Colors.black),
                ),
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
          Positioned(
            right: size.height * 0.02,
            left: size.height * 0.02,
            bottom: size.height * 0.03,
            height: size.height * .07,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue[100]),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                          side: BorderSide(color: Colors.blue[100]!)))),
              onPressed: () async {
                _state.pageStatus(PageState.workout);
              },
              child: Center(
                child: Text(
                  'Skip',
                  style: TextStyle(
                      fontSize: size.height * .030, color: Colors.black),
                ),
              ),
            ),
          )
        ],
      );
    }));
  }
}



