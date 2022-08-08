import 'dart:convert';

import 'package:builderworkoutplanner/models/exercise_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  Prefs();

  Future saveData({name, required List<Company> plan}) async {
    final prefs = await SharedPreferences.getInstance();
    List<Plan>? _oldData;
    try {
      // print('is weight');
      // print(plan[0].sets![0].weightController!.text);
      String? plans = await prefs.getString('plans');
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
    await prefs.setString('plans', jsonEncode(json));
    print(json);
  }

  Future deleteData({index}) async {
    final prefs = await SharedPreferences.getInstance();
    List<Plan>? _newData;
    try {
      String? plans = await prefs.getString('plans');
      _newData = AllPlans.fromJson(jsonDecode(plans!)).plans;
      _newData!.removeAt(index);
      var json = AllPlans(plans: _newData).toJson();
      await prefs.setString('plans', jsonEncode(json));
    } catch (e) {
      print(e);
    }
  }

  Future<AllPlans> getData() async {
    final prefs = await SharedPreferences.getInstance();
    AllPlans? allPlans;
    try {
      String? plans = await prefs.getString('plans');
      allPlans = AllPlans.fromJson(jsonDecode(plans!));
      return allPlans;
    } catch (e) {
      print(e);
      return AllPlans();
    }
  }
}
