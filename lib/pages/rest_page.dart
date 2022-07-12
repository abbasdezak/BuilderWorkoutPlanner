import 'dart:async';
import 'package:builderworkoutplanner/models/exercise_model.dart';
import 'package:builderworkoutplanner/models/time_helper.dart';
import 'package:builderworkoutplanner/pages/home_page.dart';
import 'package:builderworkoutplanner/pages/workout_page.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class RestPage extends StatefulWidget {
  final int? currentIndex;
  final int? totalIndex;
  final String? nextExerciseName;

  const RestPage({
    Key? key,
    this.currentIndex,
    this.totalIndex,
    this.nextExerciseName,
  }) : super(key: key);

  @override
  _RestPageState createState() => _RestPageState();
}

class _RestPageState extends State<RestPage> with WidgetsBindingObserver {
  Timer? _timer;
  bool _firstRun = false;
  int? endTime;
  int _currIndex = 1;
  FlareActor _flareActor = FlareActor(
    'assets/circle.flr',
    animation: 'Alarm',
    color: Colors.blue,
  );

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        _timer!.cancel();
        print('state = $state\n ${_timer!.isActive}');

        break;
      case AppLifecycleState.resumed:
        startTimer(endTime!);
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
    _currIndex = widget.currentIndex! + 1;
    double linearValue = (_currIndex) / widget.totalIndex!;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
          future: TimeHelper.dataGetter('Settings', 'Setting'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map data = snapshot.data as Map;
              if (!_firstRun) {
                endTime = data['Rest'] as int;
                _firstRun = true;
                startTimer(endTime!);
              }
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
                                    await Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                      return HomePage();
                                    }));
                                  },
                                  icon: Icon(Icons.arrow_back_ios))),
                          Container(
                              margin: EdgeInsets.all(15),
                              alignment: Alignment.topRight,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.more_horiz))),
                        ],
                      ),
                      Container(
                        width: size.width * .8,
                        child: Stack(
                          children: [
                            Positioned(
                              child: Text('Next : ${widget.nextExerciseName}',
                                  style: TextStyle(
                                      fontSize: size.height * .03,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Positioned(
                              right: 0,
                              child: Text('${_currIndex}/${widget.totalIndex}',
                                  style: TextStyle(
                                      fontSize: size.height * .038,
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
                                    fontSize: size.height * .038,
                                    color: Colors.white),
                              ))
                            ],
                          )),
                      SizedBox(
                        height: 45,
                      ),
                      Center(
                        child: Text(
                          '$endTime',
                          style: TextStyle(
                              fontSize: size.height * .025,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Seconds left',
                          style: TextStyle(
                              fontSize: size.height * .030,
                              color: Colors.black),
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
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue[100]),
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.0),
                                  side: BorderSide(color: Colors.blue[100]!)))),
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Text(
                          'Skip',
                          style: TextStyle(
                              fontSize: size.height * .030,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  )
                ],
              );
            } else {
              return Center();
            }
          }),
    );
  }

  void startTimer(int time) {
    _timer =
        new Timer.periodic(const Duration(seconds: 1), (Timer timer) async {
      if (this.mounted) {
        if (time == 0) {
          Navigator.pop(context);
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            time--;
            endTime = time;
          });
        }
      }
    });
  }
}


// CountdownTimer(
//                               endTime: endTime,
//                               controller: _timerController,
//                               widgetBuilder: (BuildContext context,
//                                   CurrentRemainingTime? time) {
//                                 if (time!.sec == 1) {
//                                   Navigator.pop(context);
//                                 }
//                                 return Text(
//                                   '${time.sec! - 1}',
//                                   style: TextStyle(
//                                       fontSize: size.height * .025,
//                                       fontWeight: FontWeight.bold),
//                                 );
//                               })

