import 'package:builderworkoutplanner/app/core/model/events.dart';
import 'package:builderworkoutplanner/app/core/model/time_helper.dart';
import 'package:builderworkoutplanner/app/core/values/app_colors.dart';
import 'package:builderworkoutplanner/app/modules/statics/controllers/stats_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class StatusCalendar extends StatelessWidget {
  CalendarFormat format = CalendarFormat.month;
  StatsController _statsController = Get.put(StatsController());

  // _fetchData() async {
  //   try {
  //     _dateMap = await TimeHelper.dataGetter('dates', 'date');

  //     List dates = _dateMap['workedout'];
  //     // print('these are dates $dates');
  //     dates.forEach((element) {
  //       var now = DateTime.parse(element);
  //       var createTime = '${DateTime(now.year, now.month, now.day)}Z';
  //       selectedEvents[DateTime.parse(createTime)] = [Event(id: 'event')];
  //     });
  //     weeksCount =
  //         TimeHelper.workoutsCounter(selectedEvents.keys.toList())['Week'];
  //     monthCounts =
  //         TimeHelper.workoutsCounter(selectedEvents.keys.toList())['Month'];

  //     print(selectedEvents.keys.toList());
  //   } catch (e) {}
  //   return await TimeHelper.dataGetter('Settings', 'Setting');
  // }
  List<Event> getEventsfromDay(DateTime date) {
    return _statsController.selectedEvents[date] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.grey[200]),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 5),
      child: _calendar(),
    ));
  }

  Widget _calendar() {
    return TableCalendar(
      focusedDay: DateTime.now(),
      firstDay: DateTime(1990),
      lastDay: DateTime(2050),
      calendarFormat: format,

      startingDayOfWeek: StartingDayOfWeek.sunday,
      daysOfWeekVisible: true,

      selectedDayPredicate: (DateTime date) {
        return isSameDay(DateTime.now(), date);
      },

      eventLoader: getEventsfromDay,

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
    );
  }
}
