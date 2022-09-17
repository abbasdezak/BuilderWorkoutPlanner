import 'package:builderworkoutplanner/app/core/model/events.dart';
import 'package:builderworkoutplanner/app/my_app.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import '../../../core/model/exercise_model.dart';

class CongratPage extends StatelessWidget {

  final LocalStorage localStorage = new LocalStorage('dates');

  Map<DateTime, List<Event>> selectedEvents = {};
  int? weeksCount;
  final String workoutName;
  Plan? plan;

  CongratPage({Key? key, required this.workoutName}) : super(key: key);

  // setUp() async {
  //   await localStorage.ready;
  //   if (localStorage.getItem('date') != null) {
  //     Map userMap = localStorage.getItem('date');

  //     List dates = userMap['workedout'];
  //     // print('these are dates $dates');

  //     setState(() {
  //       dates.forEach((element) {
  //         var now = DateTime.parse(element);
  //         var createTime = '${DateTime(now.year, now.month, now.day)}Z';
  //         selectedEvents[DateTime.parse(createTime)] = [Event(id: 'event')];
  //       });
  //     });
  //     weeksCount =
  //         TimeHelper.workoutsCounter(selectedEvents.keys.toList())['Week'];

  //     print(selectedEvents.keys.toList());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * .15,
              ),
              Text(
                'Workout Done!',
                style: TextStyle(
                    fontSize: size.height * .03, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: size.height * .2,
              ),
              Icon(
                Icons.sentiment_satisfied_alt_sharp,
                size: size.height * .1,
                color: Colors.blue[900],
              ),
              SizedBox(
                height: size.height * .07,
              ),
              SizedBox(height: size.height * .02),
              Text(
                "Congratulation!\n\nYou've become one step closer to your goals!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: size.height * .02, fontWeight: FontWeight.w200),
              ),
            ],
          ),
          Positioned(
              bottom: size.height * .03,
              left: size.width * .1,
              right: size.width * .1,
              top: size.height * .9,
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color(Colors.blue[100]!.value.toInt()))),
                child: Text(
                  'Se stats',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: size.height * .025,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => HomePage(
                                currIndex: 0,
                              )));
                },
              ))
        ],
      ),
    ));
  }
}
