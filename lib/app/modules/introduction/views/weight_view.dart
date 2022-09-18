import 'package:builderworkoutplanner/app/core/values/theme.dart';
import 'package:builderworkoutplanner/app/modules/introduction/controllers/intro_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

class WeightView extends StatelessWidget {
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
            '3 of 4',
            style: subTitleStyleGrey,
          ),
          SizedBox(
            height: size.height * .05,
          ),
          Text(
            'How much do you weight?',
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
            height: size.height * .1,
          ),
          Obx(() => Text(
                '${introController.infos.value.weight!} kg',
                style: headerTitleStyle.copyWith(fontWeight: FontWeight.w100),
              )),
          SizedBox(
            height: size.height * .1,
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
                      introController.introPageStatus(IntroPageStatus.age);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.blue[900],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () =>
                      introController.introPageStatus(IntroPageStatus.height),
                  child: Container(
                      width: size.width * .8,
                      alignment: Alignment.center,
                      child: Text('Continue',
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
          axis: Axis.horizontal,
          itemCount: 20,
          itemWidth: 20,
          textMapper: (numberText) => '|',
          textStyle: subTitleStyleGrey,
          selectedTextStyle: TextStyle(color: Colors.blue[700], fontSize: 40),
          minValue: 5,
          maxValue: 200,
          value: int.parse(introController.infos.value.weight!),
          onChanged: (val) =>
              introController.infos(_data.copyWith(weight: val.toString())));
    });
  }
}
