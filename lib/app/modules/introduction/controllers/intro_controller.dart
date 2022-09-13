import 'package:builderworkoutplanner/app/data/local/preference/prefs.dart';
import 'package:builderworkoutplanner/app/modules/introduction/model/info_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum IntroPageStatus { gender, age, weight, height }

class IntroController extends GetxController {
  var isInitiated = false.obs;
  var introPageStatus = IntroPageStatus.gender.obs;
  var infos = InfoModel(age: '20', weight: '70', height: '178').obs;
  var color1 = Colors.white.obs;
  var color2 = Colors.white.obs;
  @override
  void onInit() async {
    try {
      await Prefs().getPersonalInfo();
      isInitiated(true);
    } catch (e) {
      print(e);
    }
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  savePersonalInformations() {
    Prefs().savePersonalInformations(infos.value);
  }
}
