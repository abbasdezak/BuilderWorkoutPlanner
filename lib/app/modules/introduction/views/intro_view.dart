import 'package:builderworkoutplanner/app/modules/home/views/home_view.dart';
import 'package:builderworkoutplanner/app/modules/introduction/controllers/intro_controller.dart';
import 'package:builderworkoutplanner/app/modules/introduction/views/height_view.dart';
import 'package:builderworkoutplanner/app/modules/introduction/views/weight_view.dart';
import 'package:builderworkoutplanner/app/my_app.dart';
import 'package:builderworkoutplanner/main.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import 'age_view.dart';
import 'gender_view.dart';

class IntroView extends StatelessWidget {
  const IntroView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<IntroController>(
      init: IntroController(),
      builder: (state) {
        switch (state.introPageStatus.value) {
          case IntroPageStatus.gender:
            return GenderView();
          case IntroPageStatus.age:
            return AgeView();
          case IntroPageStatus.weight:
            return WeightView();
          case IntroPageStatus.height:
            return HeightView();
        }
      },
    );
  }
}
