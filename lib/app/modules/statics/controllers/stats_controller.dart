import 'package:builderworkoutplanner/app/core/model/events.dart';
import 'package:builderworkoutplanner/app/core/model/time_helper.dart';
import 'package:builderworkoutplanner/app/data/local/preference/prefs.dart';
import 'package:builderworkoutplanner/app/modules/home/model/chart_sample_data.dart';
import 'package:get/get.dart';

class StatsController extends GetxController {
  var workoutDates = <ChartSampleData>[].obs;
  var selectedEvents = <DateTime, List<Event>>{}.obs;
  var lastWorkout = Event().obs;

  var workoutCompleted = 0.obs;
  var tonnageLifted = 0.obs;
  var weightKg = 0.obs;
  var bmi = 0.0.obs;

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  initData() async {
    print('init Data Called');

    var dummyforbmi = await Prefs().getPersonalInfo();
    var dummyfordetails = await Prefs().getWorkoutDetails();

    print('dummy for details : \n ${dummyfordetails.toJson()}');

    List<DateTime> dummyfordates = [];
    int dummyforweight = 0;
    Map<DateTime, List<Event>> dummyforselectedevents = {};

    dummyfordates.forEach((element) {
      var now = DateTime.parse(element.toString());
      var createTime = '${DateTime(now.year, now.month, now.day)}Z';
      dummyforselectedevents[DateTime.parse(createTime)] = [Event(id: 'event')];
    });

    double weight = int.parse(dummyforbmi.weight!) * 1.0;
    double height = int.parse(dummyforbmi.height!) / 100;

    bmi(weight / (height * height));

    weightKg(int.parse(dummyforbmi.weight!));

    dummyfordetails.events!.forEach((e) {
      dummyforweight += (e.exercisesWeight! * e.exercisesRepetations!);
      e.dateTime!.forEach((element) {
        dummyfordates.add(element);
      });
    });

    tonnageLifted(dummyforweight);

    workoutCompleted(dummyfordates.length);

    workoutDates(TimeHelper().statsChartSamples(dates: dummyfordates));

    selectedEvents(dummyforselectedevents);

    lastWorkout(dummyfordetails.events!.last);

    workoutDates.refresh();
  }
}
