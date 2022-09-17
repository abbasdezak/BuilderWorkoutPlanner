import 'package:builderworkoutplanner/app/core/values/app_colors.dart';
import 'package:builderworkoutplanner/app/core/values/theme.dart';
import 'package:builderworkoutplanner/app/modules/statics/controllers/stats_controller.dart';
import 'package:builderworkoutplanner/app/modules/statics/views/calendar_page.dart';
import 'package:builderworkoutplanner/app/modules/statics/widgets/stats_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatsPage extends StatelessWidget {
  StatsPage({Key? key}) : super(key: key);
  StatsController _stats = Get.put(StatsController());
  String? _message;

  // Map<DateTime, List<Event>> selectedEvents = {};

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
              padding: EdgeInsets.only(
                  top: size.height * .06,
                  left: size.height * .03,
                  bottom: size.height * .05),
              alignment: Alignment.centerLeft,
              child: Text(
                'Statistics',
                style: headerTitleStyle,
              )),
          StatsChart(),
          _gridCard(size),
          Container(width: size.width, height: size.height*.49, child: StatusCalendar()),
        ]),
      ),
    );
  }

  _gridCard(size) {
    return Obx(() {
      if (_stats.bmi < 18.5) {
        _message = "Underweight";
      } else if (_stats.bmi < 25) {
        _message = 'Great';
      } else if (_stats.bmi < 30) {
        _message = 'Overweight';
      } else {
        _message = 'Obese';
      }
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _card(
                  icon: Icons.timeline,
                  size: size,
                  text: '${_stats.workoutCompleted.value}',
                  subText: 'Workouts Done'),
              _card(
                  icon: Icons.fitness_center_outlined,
                  size: size,
                  text: '${_stats.tonnageLifted.value} Kg',
                  subText: 'Lifted'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _card(
                  icon: Icons.animation_outlined,
                  size: size,
                  text: '${_stats.bmi.value.ceilToDouble()}',
                  subText: 'BMI'),
              _card(
                  icon: Icons.fitbit_outlined,
                  size: size,
                  text: '$_message',
                  subText: 'Health Status'),
            ],
          ),
        ],
      );
    });
  }

  _card({size, icon, ontap, text, subText}) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
          width: size.width * .46,
          height: size.height * .15,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[200]!, width: 1)),
          padding: EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 30,
                color: AppColors.Blue7,
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: titleStyle,
                  ),
                  Text(
                    subText,
                    style: smallTitleStyleGrey,
                  ),
                ],
              )
            ],
          )),
    );
  }

  // _calendar(size) {
  //   return Container(
  //     // height: size.height * .4,
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(20), color: Colors.grey[200]),
  //     padding: EdgeInsets.all(10),
  //     margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 5),
  //     child: TableCalendar(
  //       focusedDay: selectedDay,
  //       firstDay: DateTime(1990),
  //       lastDay: DateTime(2050),
  //       calendarFormat: format,

  //       startingDayOfWeek: StartingDayOfWeek.sunday,
  //       daysOfWeekVisible: true,

  //       selectedDayPredicate: (DateTime date) {
  //         return isSameDay(selectedDay, date);
  //       },

  //       // eventLoader: _getEventsfromDay,

  //       //To style the Calendar
  //       calendarStyle: CalendarStyle(
  //         isTodayHighlighted: true,
  //         selectedDecoration: BoxDecoration(
  //           color: AppColors.darkBlue,
  //           shape: BoxShape.rectangle,
  //           borderRadius: BorderRadius.circular(8.0),
  //         ),
  //         selectedTextStyle: TextStyle(color: Colors.white),
  //         todayDecoration: BoxDecoration(
  //           color: Colors.purpleAccent,
  //           shape: BoxShape.rectangle,
  //           borderRadius: BorderRadius.circular(5.0),
  //         ),
  //         defaultDecoration: BoxDecoration(
  //           shape: BoxShape.rectangle,
  //           borderRadius: BorderRadius.circular(5.0),
  //         ),
  //         weekendDecoration: BoxDecoration(
  //           shape: BoxShape.rectangle,
  //           borderRadius: BorderRadius.circular(5.0),
  //         ),
  //       ),
  //       headerStyle: HeaderStyle(
  //         formatButtonVisible: false,
  //         titleCentered: true,
  //         formatButtonShowsNext: false,
  //         formatButtonDecoration: BoxDecoration(
  //           color: Colors.blue,
  //           borderRadius: BorderRadius.circular(5.0),
  //         ),
  //         formatButtonTextStyle: TextStyle(
  //           color: Colors.white,
  //         ),
  //       ),
  //     ),
  //   );
  // }

}
