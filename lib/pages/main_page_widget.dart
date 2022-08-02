import 'package:builderworkoutplanner/models/events.dart';
import 'package:builderworkoutplanner/models/json_plans_model.dart';
import 'package:builderworkoutplanner/models/prefs.dart';
import 'package:builderworkoutplanner/models/time_helper.dart';
import 'package:builderworkoutplanner/pages/add_exercise_page.dart';
import 'package:builderworkoutplanner/pages/add_new_page.dart';
import 'package:builderworkoutplanner/pages/plans_list.dart';
import 'package:builderworkoutplanner/widgets/listview_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../data.dart';

class MainPageWidget extends StatefulWidget {
  final dataRquiredForBuild;
  const MainPageWidget({Key? key, this.dataRquiredForBuild}) : super(key: key);

  @override
  _MainPageWidgetState createState() => _MainPageWidgetState();
}

class _MainPageWidgetState extends State<MainPageWidget> {
  int imageIndex = 1;
  Map? data;
  CalendarFormat format = CalendarFormat.week;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  Map<DateTime, List<Event>> selectedEvents = {};
  Map _dateMap = {};

  @override
  void initState() {
    super.initState();
  }

  dataLoader() async {
    data = await TimeHelper.dataGetter('Settings', 'Setting');
    _dateMap = await TimeHelper.dataGetter('dates', 'date');

    List dates = _dateMap['workedout'];
    print('these are dates $dates');
    print('these are dates ${Prefs().getData()}');
    dates.forEach((element) {
      var now = DateTime.parse(element);
      var createTime = '${DateTime(now.year, now.month, now.day)}Z';
      selectedEvents[DateTime.parse(createTime)] = [Event(title: 'event')];
    });
    return await Prefs().getData();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 10),
        alignment: Alignment.topCenter,
        child: Column(children: [
          _appBar(),
          _calendar(),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 15, top: 15),
            child: Text(
              'Your workouts',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 21),
            ),
          ),
          _listView(size),
        ]));
  }

  Widget _listView(Size size) {
    return FutureBuilder(
        future: dataLoader(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var _p = snapshot.data as JsonPlansModel;

            return Expanded(
              child: SingleChildScrollView(
                child: (_p.plans?.length == 0)
                    ? Column(
                        children: [
                          Image.asset(
                            "assets/images/empty.jpg",
                            fit: BoxFit.contain,
                          ),
                          Text(
                            "Nothing is here! \n Click Add New to add new plans :)",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      )
                    : ListView.builder(
                        itemCount: _p.plans?.length ?? 0,
                        itemBuilder: (context, index) {
                          if (imageIndex > 11) {
                            imageIndex = 1;
                          } else {
                            imageIndex++;
                          }
                          return PlansCards(
                            onTap: () async {
                              await Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return PlansList(
                                    plans: _p.plans?[index] ?? Plans());
                              }));
                            },
                            icon: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                Prefs().deleteData(index: index);
                                setState(() {});
                              },
                            ),
                            image: Image.asset('assets/images/$imageIndex.jpg'),
                            size: size,
                            title: _p.plans?[index].name,
                            subTitle: '${_p.plans?.length} Splits',
                            titleFontSize: size.height * 0.0265,
                          );
                        }),
              ),
            );
          } else {
            return Center(
              child: LinearProgressIndicator(),
            );
          }
        });
  }

  _appBar() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(15),
          alignment: Alignment.topLeft,

          // ignore: prefer_const_literals_to_create_immutables
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                    border: Border.all(color: Color(secondColor))),
                child: Container(
                    margin: EdgeInsets.all(10),
                    child: Image(
                      image: AssetImage(data?['Gender'] == 1
                          ? "assets/icons/male.jpg"
                          : "assets/icons/female.jpg"),
                      height: 40,
                      width: 40,
                    )),
              ),
              Text(
                "Hey ${data?['Name']}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              Spacer(),
              Container(
                child: IconButton(
                  onPressed: () {
                    Get.to(AddExercise());
                  },
                  icon: Icon(Icons.add),
                ),
                // margin: EdgeInsets.only(left: size.width * .44),
              )
            ],
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(left: 15, top: 15),
          child: Text(
            'Ready to workout?',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
          ),
        ),
      ],
    );
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  Container _calendar() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.grey[200]),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 5),
      child: TableCalendar(
        focusedDay: selectedDay,
        firstDay: DateTime(1990),
        lastDay: DateTime(2050),
        calendarFormat: format,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        daysOfWeekVisible: true,
        headerVisible: false,
        selectedDayPredicate: (DateTime date) {
          return isSameDay(selectedDay, date);
        },
        eventLoader: _getEventsfromDay,
        //To style the Calendar
        calendarStyle: CalendarStyle(
          isTodayHighlighted: true,
          selectedDecoration: BoxDecoration(
            color: Colors.blue[300],
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.0),
          ),
          weekendTextStyle: TextStyle(fontSize: 20),
          defaultTextStyle: TextStyle(fontSize: 20),
          selectedTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          todayDecoration: BoxDecoration(
            color: Colors.purpleAccent,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5.0),
          ),
          defaultDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }
}
