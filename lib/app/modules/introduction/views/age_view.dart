import 'package:builderworkoutplanner/app/core/values/theme.dart';
import 'package:builderworkoutplanner/app/modules/introduction/controllers/intro_controller.dart';
import 'package:builderworkoutplanner/app/modules/introduction/model/info_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

class AgeView extends StatelessWidget {
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
            '2 of 4',
            style: subTitleStyleGrey,
          ),
          SizedBox(
            height: size.height * .05,
          ),
          Text(
            'How old are you?',
            style: bigTitleStyle,
          ),
          SizedBox(
            height: size.height * .02,
          ),
          Text(
            'This is used to make better\n workout suggestion',
            style: subTitleStyleGrey,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: size.height * .12,
          ),
          Obx(() {
            var _data = introController.infos.value;

            return NumberPicker(
                textStyle: subTitleStyleGrey,
                itemHeight: 60,
                selectedTextStyle:
                    TextStyle(color: Colors.blue[900], fontSize: 30),
                minValue: 5,
                maxValue: 120,
                value: int.parse(introController.infos.value.age!),
                onChanged: (val) =>
                    introController.infos(_data.copyWith(age: val.toString())));
          }),
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
                      introController.introPageStatus(IntroPageStatus.gender);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.blue[900],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () =>
                      introController.introPageStatus(IntroPageStatus.weight),
                  child: Container(
                      width: size.width * .8,
                      alignment: Alignment.center,
                      child: Text('Continue',
                          style: TextStyle(
                              fontSize: 18, color: Colors.blue[900]))),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  _squareButton(size) {
    return Obx(
      () {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if (introController.infos.value.isMale == true) {
                  introController.infos(InfoModel(isMale: null));
                  introController.color1(Colors.white);
                  introController.color2(Colors.white);
                } else {
                  introController.infos(InfoModel(isMale: true));
                  introController.color1(Colors.blue[900]!);
                  introController.color2(Colors.white);
                }
              },
              child: AnimatedContainer(
                margin: EdgeInsets.all(15),
                width: size.width * .27,
                height: size.height * .17,
                decoration: BoxDecoration(
                    color: introController.color1.value,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.blue[900]!)),
                duration: Duration(milliseconds: 1500),
                curve: Curves.fastOutSlowIn,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.male,
                        color: introController.color1.value == Colors.white
                            ? Colors.blue[900]
                            : Colors.white,
                        size: size.height * .07),
                    Text('Man',
                        style: TextStyle(
                            color: introController.color1.value == Colors.white
                                ? Colors.blue[900]
                                : Colors.white))
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (introController.infos.value.isMale == false) {
                  introController.infos(InfoModel(isMale: null));
                  introController.color1(Colors.white);
                  introController.color2(Colors.white);
                } else {
                  introController.infos(InfoModel(isMale: false));
                  introController.color2.value = Colors.blue[900]!;
                  introController.color1(Colors.white);
                }
              },
              child: AnimatedContainer(
                margin: EdgeInsets.all(15),
                width: size.width * .27,
                height: size.height * .17,
                curve: Curves.fastOutSlowIn,
                decoration: BoxDecoration(
                    color: introController.color2.value,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.blue[900]!)),
                duration: Duration(milliseconds: 2000),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.female,
                      color: introController.color2.value == Colors.white
                          ? Colors.blue[900]
                          : Colors.white,
                      size: size.height * .07,
                    ),
                    Text(
                      'Woman',
                      style: TextStyle(
                          color: introController.color2.value == Colors.white
                              ? Colors.blue[900]
                              : Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
