import 'dart:async';

import 'package:builderworkoutplanner/app/core/model/events.dart';
import 'package:builderworkoutplanner/app/core/model/time_helper.dart';
import 'package:builderworkoutplanner/app/core/values/app_colors.dart';
import 'package:builderworkoutplanner/app/modules/statics/widgets/calendar_card.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  Map<DateTime, List<Event>> selectedEvents = {};
  CalendarFormat format = CalendarFormat.twoWeeks;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  int? weeksCount, monthCounts;
  Map _dateMap = {};
  Map _personalMap = {};
  TextEditingController _eventController = TextEditingController();
  double? _bmi;
  String? _message;

  _fetchData() async {
    _personalMap = await TimeHelper.dataGetter('Settings', 'Setting');

    double weight = _personalMap['Weight'] * 1.0;
    double height = _personalMap['Height'] / 100;
    _bmi = weight / (height * height);

    if (_bmi! < 18.5) {
      _message = "You are underweight";
    } else if (_bmi! < 25) {
      _message = 'Your are fine';
    } else if (_bmi! < 30) {
      _message = 'You are overweight';
    } else {
      _message = 'You are obese';
    }
    try {
      _dateMap = await TimeHelper.dataGetter('dates', 'date');

      List dates = _dateMap['workedout'];
      // print('these are dates $dates');
      dates.forEach((element) {
        var now = DateTime.parse(element);
        var createTime = '${DateTime(now.year, now.month, now.day)}Z';
        selectedEvents[DateTime.parse(createTime)] = [Event(id: 'event')];
      });
      weeksCount =
          TimeHelper.workoutsCounter(selectedEvents.keys.toList())['Week'];
      monthCounts =
          TimeHelper.workoutsCounter(selectedEvents.keys.toList())['Month'];

      print(selectedEvents.keys.toList());
    } catch (e) {}
    return await TimeHelper.dataGetter('Settings', 'Setting');
  }

  @override
  void initState() {
    _fetchData();

    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
          future: _fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * .1,
                    ),
                    Text(
                      'Stats 🚀',
                      style: TextStyle(
                          fontSize: size.height * .032,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CalendarCard(
                          subTextSize: size.height * .02,
                          textSize: size.height * .03,
                          getSize: size.width * .28,
                          size: size,
                          textCard: '${_personalMap['Weight']} KG',
                          subTextCard: 'Weight',
                        ),
                        CalendarCard(
                          subTextSize: size.height * .02,
                          textSize: size.height * .03,
                          getSize: size.width * .28,
                          size: size,
                          textCard: '${_personalMap['Height']} CM',
                          subTextCard: 'Height',
                        ),
                        CalendarCard(
                          subTextSize: size.height * .02,
                          textSize: size.height * .028,
                          getSize: size.width * .28,
                          size: size,
                          textCard: '${_bmi!.toStringAsFixed(1)} BMI',
                          subTextCard: '$_message',
                        ),
                      ],
                    ),
                    _calendar(),
                    Container(
                      width: size.width * .2,
                      height: 6,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.75),
                          borderRadius: BorderRadius.circular(100)),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (format == CalendarFormat.month) {
                              format = CalendarFormat.twoWeeks;
                            } else {
                              format = CalendarFormat.month;
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height * .01,
                    ),
                    Text(
                      'Recent activity',
                      style: TextStyle(
                          fontSize: size.height * .02,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.withOpacity(.5)),
                    ),
                    SizedBox(
                      height: size.height * .05,
                    ),
                    Text(
                      'Workouts 💪',
                      style: TextStyle(
                          fontSize: size.height * .032,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: size.height * .03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CalendarCard(
                          getSize: size.width * 0.43,
                          size: size,
                          textCard: weeksCount != null ? '$weeksCount' : '0',
                          subTextCard: 'ThisWeek',
                          subTextSize: size.height * .025,
                          textSize: size.height * .04,
                        ),
                        CalendarCard(
                          subTextSize: size.height * .025,
                          textSize: size.height * .04,
                          getSize: size.width * 0.43,
                          size: size,
                          textCard: monthCounts != null ? '$monthCounts' : '0',
                          subTextCard: 'ThisMonth',
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  _calendar() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.grey[200]),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 5),
      child: TableCalendar(
        focusedDay: selectedDay,
        firstDay: DateTime(1990),
        lastDay: DateTime(2050),
        calendarFormat: format,

        startingDayOfWeek: StartingDayOfWeek.sunday,
        daysOfWeekVisible: true,

        selectedDayPredicate: (DateTime date) {
          return isSameDay(selectedDay, date);
        },

        eventLoader: _getEventsfromDay,

        //To style the Calendar
        calendarStyle: CalendarStyle(
          isTodayHighlighted: true,
          selectedDecoration: BoxDecoration(
            color: AppColors.darkBlue,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.0),
          ),
          selectedTextStyle: TextStyle(color: Colors.white),
          todayDecoration: BoxDecoration(
            color: Colors.purpleAccent,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5.0),
          ),
          defaultDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5.0),
          ),
          weekendDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          formatButtonShowsNext: false,
          formatButtonDecoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(5.0),
          ),
          formatButtonTextStyle: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
