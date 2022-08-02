import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'json_plans_model.dart';

class Prefs {
  Prefs();

  Future saveData({name, splits}) async {
    final prefs = await SharedPreferences.getInstance();
    List<Plans>? _oldData;
    try {
      String? plans = await prefs.getString('plans');
      _oldData = JsonPlansModel.fromJson(jsonDecode(plans!)).plans;

      _oldData!.add(Plans(
          name: name,
          splits: splits
              .map((e) => Splits(
                  imgUrl: "",
                  exrcs: e.wrkts!.map((e) => "${e.name}").toList(),
                  name: "${e.name}"))
              .toList()));
      var json = JsonPlansModel(plans: _oldData).toJson();
      await prefs.setString('plans', jsonEncode(json));
    } catch (e) {
      _oldData = [
        Plans(
            name: name,
            splits: splits
                .map((e) => Splits(
                    imgUrl: "",
                    exrcs: e.wrkts!.map((e) => "${e.name}").toList(),
                    name: "${e.name}"))
                .toList())
      ];
      var json = JsonPlansModel(plans: _oldData).toJson();
      await prefs.setString('plans', jsonEncode(json));
    }
  }

  Future<JsonPlansModel> getData() async {
    final prefs = await SharedPreferences.getInstance();
    JsonPlansModel? jsonPlansModel;
    try {
      String? plans = await prefs.getString('plans');
      jsonPlansModel = JsonPlansModel.fromJson(jsonDecode(plans!));
      return jsonPlansModel;
    } catch (e) {
      print(e);
       return JsonPlansModel();
    }
  }

  Future deleteData({index}) async {
    final prefs = await SharedPreferences.getInstance();
    List<Plans>? _newData;
    try {
      String? plans = await prefs.getString('plans');
      _newData = JsonPlansModel.fromJson(jsonDecode(plans!)).plans;
      _newData!.removeAt(index);
      var json = JsonPlansModel(plans: _newData).toJson();
      await prefs.setString('plans', jsonEncode(json));
    } catch (e) {
      print(e);
    }
  }
}
