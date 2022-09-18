import 'dart:convert';
import 'package:builderworkoutplanner/app/core/model/events.dart';
import 'package:builderworkoutplanner/app/modules/introduction/model/info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/model/exercise_model.dart';

class Prefs {
  Prefs();
  static SharedPreferences? prefs;

  static void setPrefs(SharedPreferences prf) {
    prefs = prf;
  }

  editPersonalInformations(InfoModel info) async {
    var _oldData = await prefs!.getString('personalInfo');
    try {
      InfoModel data = InfoModel.fromJson(_oldData!);
      data = data.copyWith(
        isMale: info.isMale,
        age: info.age,
        height: info.height,
        weight: info.weight,
      );
      var json = data.toJson();
      print(json);
      await prefs!.setString('personalInfo', json);
    } catch (e) {
      print(e);
    }
  }

  savePersonalInformations(InfoModel info) async {
    var x = info.toJson();
    try {
      print('infos are $x');
      await prefs?.setString('personalInfo', x);
    } catch (e) {
      print('error is $e');
    }
  }

  Future<InfoModel> getPersonalInfo() async {
    try {
      var jsonX = await prefs!.getString('personalInfo');
      InfoModel data = InfoModel.fromJson(jsonX!);
      return data;
    } catch (e) {
      throw Exception(e);
    }
  }

  saveWorkoutDetails(
      {required id, required weight, required DateTime dateTime}) async {
    List<Event>? _data;
    try {
      String? dates = await prefs?.getString('workoutDates');
      _data = Events.fromJson(dates!).events;
//check if there is a existing event if true update the event repetition number
      if (!_data!.every((Event element) {
        return element.id != id;
      })) {
        Event existed = _data.firstWhere((element) => element.id == id);
        _data.removeWhere((element) => element.id == existed.id);
        int pastReptitation = existed.exercisesRepetations!;
        existed = existed.copyWith(
            exercisesRepetations: pastReptitation + 1,
            dateTime: [...existed.dateTime!, dateTime]);
        _data.add(existed);
      } else {
        _data.add(Event(
            dateTime: [dateTime],
            exercisesRepetations: 1,
            exercisesWeight: weight,
            id: id));
      }
    } catch (e) {
      print(e);
      _data = [
        Event(
            dateTime: [dateTime],
            exercisesRepetations: 1,
            exercisesWeight: weight,
            id: id)
      ];
    }

    var json = Events(events: _data).toJson();
    await prefs?.setString('workoutDates', json);
  }

  Future<Events> getWorkoutDetails() async {
    Events events;
    try {
      var plans = await prefs?.getString('workoutDates');
      events = Events.fromJson(plans!);
      return events;
    } catch (e) {
      print('Catched Execption $e');
      return Events();
    }
  }

  Future saveData({name, required List<Company> plan}) async {
    List<Plan>? _oldData;
    try {
      // print('is weight');
      // print(plan[0].sets![0].weightController!.text);
      String? plans = await prefs?.getString('plans');
      _oldData = AllPlans.fromJson(jsonDecode(plans!)).plans;

      _oldData!.add(Plan(
          planName: name,
          exercises: plan
              .map((e) => Company(
                  name: e.name,
                  howTo: e.howTo,
                  id: e.id,
                  imgurl: e.imgurl,
                  sets: e.sets,
                  usage: e.usage))
              .toList()));
    } catch (e) {
      print(e);
      _oldData = [
        Plan(
            planName: name,
            exercises: plan
                .map((e) => Company(
                    name: e.name,
                    howTo: e.howTo,
                    id: e.id,
                    imgurl: e.imgurl,
                    sets: e.sets,
                    usage: e.usage))
                .toList())
      ];
    }

    var json = AllPlans(plans: _oldData).toJson();
    await prefs?.setString('plans', jsonEncode(json));
    print(json);
  }

  Future deleteData({index}) async {
    List<Plan>? _newData;
    try {
      String? plans = await prefs?.getString('plans');
      _newData = AllPlans.fromJson(jsonDecode(plans!)).plans;
      _newData!.removeAt(index);
      var json = AllPlans(plans: _newData).toJson();
      await prefs?.setString('plans', jsonEncode(json));
    } catch (e) {
      print(e);
    }
  }

  Future<AllPlans> getData() async {
    AllPlans? allPlans;
    try {
      String? plans = await prefs?.getString('plans');
      allPlans = AllPlans.fromJson(jsonDecode(plans!));
      return allPlans;
    } catch (e) {
      print(e);
      return AllPlans();
    }
  }
}
