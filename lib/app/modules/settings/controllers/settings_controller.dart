import 'package:builderworkoutplanner/app/data/local/preference/prefs.dart';
import 'package:builderworkoutplanner/app/modules/introduction/model/info_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/model/events.dart';

class SettingsController extends GetxController {
  final TextEditingController textController = TextEditingController();
  var infos = InfoModel().obs;
  var historyLists = Events().obs;
  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  String get getFormText {
    return textController.text;
  }

  void clear() {
    textController.clear();
  }

  loadData() async {
    var historyData = await Prefs().getWorkoutDetails();
    historyLists(historyData);
    var personalData = await Prefs().getPersonalInfo();
    infos(personalData);
  }

  editPersonalInfo(InfoModel info) async {
    await Prefs().editPersonalInformations(info);
    loadData();
  }
}
