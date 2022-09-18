import 'package:builderworkoutplanner/app/core/values/theme.dart';
import 'package:builderworkoutplanner/app/data/local/preference/prefs.dart';
import 'package:builderworkoutplanner/app/modules/introduction/controllers/intro_controller.dart';
import 'package:builderworkoutplanner/app/my_app.dart';
import 'package:builderworkoutplanner/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

class HeightView extends StatelessWidget {
  IntroController introController = Get.put(IntroController());
  int _currentValue = 20;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: size.height * .05),
        alignment: Alignment.center,
        child: Column(children: [
          Text(
            '4 of 4',
            style: subTitleStyleGrey,
          ),
          SizedBox(
            height: size.height * .05,
          ),
          Text(
            'How tall are you?',
            style: bigTitleStyle,
          ),
          SizedBox(
            height: size.height * .04,
          ),
          Text(
            'This is used to set up recemendations\n just for you',
            style: subTitleStyleGrey,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: size.height * .14,
          ),
          _numPicker(),
          Spacer(),
          Container(
            width: size.width,
            height: size.height * .1,
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[300]!))),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15),
                  width: size.width * .1,
                  child: IconButton(
                    onPressed: () {
                      introController.introPageStatus(IntroPageStatus.weight);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.blue[900],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                     introController.savePersonalInformations();
                    Get.to(
                      HomePage(
                        currIndex: 1,
                      ),
                      duration: Duration(seconds: 2),
                      transition: Transition.fadeIn,
                    );
                  },
                  child: Container(
                      width: size.width * .8,
                      alignment: Alignment.center,
                      child: Text('Finish',
                          style: TextStyle(
                              fontSize: 18, color: Colors.blue[900]))),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }

  Obx _numPicker() {
    return Obx(() {
      var _data = introController.infos.value;
      return NumberPicker(
          itemCount: 3,
          itemWidth: 100,
          textMapper: (numberText) => numberText + ' cm',
          textStyle: subTitleStyleGrey,
          selectedTextStyle: TextStyle(color: Colors.blue[700], fontSize: 24),
          minValue: 5,
          maxValue: 200,
          value: int.parse(introController.infos.value.height!),
          onChanged: (val) =>
              introController.infos(_data.copyWith(height: val.toString())));
    });
  }
}
