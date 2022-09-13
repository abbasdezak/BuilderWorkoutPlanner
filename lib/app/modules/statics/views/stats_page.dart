import 'dart:math';

import 'package:builderworkoutplanner/app/core/base/core_controller.dart';
import 'package:builderworkoutplanner/app/core/model/events.dart';
import 'package:builderworkoutplanner/app/core/values/app_colors.dart';
import 'package:builderworkoutplanner/app/core/values/theme.dart';
import 'package:builderworkoutplanner/app/core/widget/app_bar.dart';
import 'package:builderworkoutplanner/app/core/widget/listview_card.dart';
import 'package:builderworkoutplanner/app/modules/home/model/chart_sample_data.dart';
import 'package:builderworkoutplanner/app/modules/home/model/grid_card.dart';
import 'package:builderworkoutplanner/app/modules/home/widget/blue_botton.dart';
import 'package:builderworkoutplanner/app/modules/home/widget/chart.dart';
import 'package:builderworkoutplanner/app/modules/statics/controllers/stats_controller.dart';
import 'package:builderworkoutplanner/app/modules/statics/widgets/stats_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:table_calendar/table_calendar.dart';

class StatsPage extends StatelessWidget {
  StatsPage({Key? key}) : super(key: key);
  var cardIcons = [
    Icons.check_circle_outline_rounded,
    Icons.fitness_center_outlined,
    Icons.animation_outlined,
    Icons.fitbit_outlined
  ];
  CoreController _controller = Get.put(CoreController());
  StatsController _stats = Get.put(StatsController());
  Map<DateTime, List<Event>> selectedEvents = {};
  CalendarFormat format = CalendarFormat.twoWeeks;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  int? weeksCount, monthCounts;
  TooltipBehavior _tooltipBehavior = TooltipBehavior(
      enable: true,
      canShowMarker: false,
      format: 'point.x : point.y',
      header: '');

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
              padding: EdgeInsets.only(
                  top: size.height * .05,
                  left: size.height * .04,
                  bottom: size.height * .05),
              alignment: Alignment.centerLeft,
              child: Text(
                'Statistics',
                style: headerTitleStyle,
              )),
          StatsChart(chartData: _stats.workoutDates),
          _gridCard(size),
          _calendar(size),
        ]),
      ),
    );
  }

  _gridCard(size) {
    return Container(
        width: size.width,
        height: size.height * .32,
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: 4,
          padding: EdgeInsets.all(10),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[200]!, width: 1)),
              padding: EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    cardIcons[index],
                    color: AppColors.Blue7,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (Random().nextInt(9) + 2).toString(),
                        style: bigTitleStyle,
                      ),
                      Text(
                        'workouts\ncompleted',
                        style: smallTitleStyleGrey,
                      ),
                    ],
                  )
                ],
              )),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.9,
          ),
        ));
  }

  _calendar(size) {
    return Container(
      // height: size.height * .4,
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

        // eventLoader: _getEventsfromDay,

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
