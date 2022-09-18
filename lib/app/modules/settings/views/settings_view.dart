import 'package:builderworkoutplanner/app/core/base/core_controller.dart';
import 'package:builderworkoutplanner/app/core/model/exercise_model.dart';
import 'package:builderworkoutplanner/app/core/values/app_colors.dart';
import 'package:builderworkoutplanner/app/core/values/theme.dart';
import 'package:builderworkoutplanner/app/core/widget/listview_card.dart';
import 'package:builderworkoutplanner/app/core/widget/rounded_text_field.dart';
import 'package:builderworkoutplanner/app/modules/introduction/model/info_model.dart';
import 'package:builderworkoutplanner/app/modules/settings/controllers/settings_controller.dart';
import 'package:builderworkoutplanner/app/modules/statics/controllers/stats_controller.dart';
import 'package:builderworkoutplanner/app/modules/workout_page/views/workout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  SettingsController _settingsController = Get.put(SettingsController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Obx(() {
      var infos = _settingsController.infos.value;
      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(
                  left: size.width * .04, top: size.height * .08),
              child: Text(
                'Settings and History',
                style: headerTitleStyle,
              ),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: size.width * .02),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 10, bottom: 15),
                    child: Text('Settings', style: bigTitleStyle),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _card(
                          icon: Icons.height_rounded,
                          ontap: () {
                            showDlg(size, 'Height');
                          },
                          size: size,
                          text: '${infos.height} cm',
                          subText: 'height'),
                      _card(
                          icon: Icons.monitor_weight_outlined,
                          ontap: () {
                            showDlg(size, 'Weight');
                          },
                          size: size,
                          text: '${infos.weight} kg',
                          subText: 'weight'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _card(
                          icon: Icons.check_circle_outline_rounded,
                          ontap: () {
                            showDlg(size, 'Age');
                          },
                          size: size,
                          text: '${infos.age} yrs',
                          subText: 'age'),
                      _card(
                          icon: Icons.male,
                          // ontap: () {
                          //   showDlg(size, 'Gender');
                          // },
                          size: size,
                          text: 'Male',
                          subText: 'gender'),
                    ],
                  ),
                  SizedBox(
                    height: size.width * .05,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 10, bottom: 15),
                    child: Text(
                      'History',
                      style: bigTitleStyle,
                    ),
                  ),
                  _settingsController.historyLists.value != null
                      ? Column(
                          children: List.generate(
                          _settingsController.historyLists.value!.length,
                          (index) => Container(
                            padding: EdgeInsets.only(
                                left: 10, right: 15, bottom: 15),
                            child: PlansCards(
                              title:
                                  '${AllPlans().nameEncoder(_settingsController.historyLists.value![index].id.toString())}'
                                      .toUpperCase(),
                              titleFontSize: titleStyle,
                              subTitle:
                                  'Repetition : ${_settingsController.historyLists.value![index].dateTime!.length} times\nLast Time : ${_settingsController.historyLists.value![index].dateTime!.last} ',
                              onTap: () => Get.to(Workout(
                                  workoutName: _settingsController
                                      .historyLists.value![index].id!)),
                              icon: Icon(
                                Icons.history,
                                size: 30,
                                color: Colors.blue[900],
                              ),
                            ),
                          ),
                        ))
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  showDlg(size, title) {
    Get.dialog(
        AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          actionsPadding: EdgeInsets.all(5),
          actions: [
            Center(child: Text('$title', style: smallTitleStyle)),
            SizedBox(
              height: 5,
            ),
            Container(
                margin: EdgeInsets.only(top: size.height * .015),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                height: size.height * .07,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!, width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Container(),
                    SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: size.width * .6,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _settingsController.textController,
                        style: TextStyle(
                            fontWeight: FontWeight.w300, color: Colors.black),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hoverColor: Colors.white,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue[900]!)),
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Cancel')),
                ElevatedButton(
                  onPressed: () async {
                    if (_settingsController.getFormText.isEmpty) {
                      Get.snackbar('Warning', 'Cant be empty',
                          snackPosition: SnackPosition.BOTTOM,
                          margin: EdgeInsets.all(30));
                    } else if (!RegExp(r'^[0-9]')
                        .hasMatch(_settingsController.getFormText)) {
                      Get.snackbar('Error', 'Only numbers are allowed',
                          snackPosition: SnackPosition.BOTTOM,
                          margin: EdgeInsets.all(30));
                    } else {
                      switch (title.toString()) {
                        case 'Height':
                          _settingsController.editPersonalInfo(InfoModel(
                              height: _settingsController.getFormText));
                          _settingsController.clear();
                          Get.back();

                          break;
                        case 'Weight':
                          _settingsController.editPersonalInfo(InfoModel(
                              weight: _settingsController.getFormText));
                          _settingsController.clear();
                          Get.back();
                          break;
                        case 'Age':
                          _settingsController.editPersonalInfo(
                              InfoModel(age: _settingsController.getFormText));
                          _settingsController.clear();
                          Get.back();
                          break;
                      }
                    }
                  },
                  child: Text('Save'),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blue[900]!)),
                )
              ],
            ),
          ],
        ),
        transitionDuration: Duration(milliseconds: 500),
        transitionCurve: Curves.easeIn);
  }

  _card({size, icon, ontap, text, subText}) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
          width: size.width * .46,
          height: size.height * .15,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[200]!, width: 1)),
          padding: EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 30,
                color: AppColors.Blue7,
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: titleStyle,
                  ),
                  Text(
                    subText,
                    style: smallTitleStyleGrey,
                  ),
                ],
              )
            ],
          )),
    );
  }
}
