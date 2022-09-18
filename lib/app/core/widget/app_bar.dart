import 'package:builderworkoutplanner/app/core/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar {
  AppBar appBar(actions) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.darkBlue,
      actions: [
        actions!,
        SizedBox(
          width: 10,
        )
      ],
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          size: 20,
        ),
        onPressed: () {
          Get.back();
        },
      ),
    );
  }
}
