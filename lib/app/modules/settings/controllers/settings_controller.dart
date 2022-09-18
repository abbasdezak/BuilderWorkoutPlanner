import 'package:builderworkoutplanner/app/data/local/preference/prefs.dart';
import 'package:builderworkoutplanner/app/modules/introduction/model/info_model.dart';
import 'package:builderworkoutplanner/app/modules/statics/controllers/stats_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/model/events.dart';

class SettingsController extends GetxController {
  final TextEditingController textController = TextEditingController();
  StatsController _statsController = Get.put(StatsController());
  var infos = InfoModel().obs;
  var historyLists = Events().events.obs;
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
    var personalData = await Prefs().getPersonalInfo();
    infos(personalData);
    var historyData = await Prefs().getWorkoutDetails();
    historyData.events!.sort(
      (a, b) => b.exercisesRepetations!.compareTo(a.exercisesRepetations!),
    );
    historyLists(historyData.events);
  }

  editPersonalInfo(InfoModel info) async {
    await Prefs().editPersonalInformations(info);

    loadData();
    await _statsController.initData();
  }
}
