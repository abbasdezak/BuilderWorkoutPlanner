import 'package:builderworkoutplanner/app/core/values/app_colors.dart';
import 'package:builderworkoutplanner/app/core/values/theme.dart';
import 'package:flutter/material.dart';

class CalendarCard extends StatelessWidget {
  final String? textCard;
  final String? subTextCard;
  final getSize;
  final textSize;
  final subTextSize;

  const CalendarCard({
    Key? key,
    required this.size,
    this.textCard,
    this.subTextCard,
    this.getSize,
    required this.textSize,
    required this.subTextSize,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getSize,
      height: getSize,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.darkBlue),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            textCard != null ? '$textCard' : '',
            style: titleStyleWhite,
          ),
          SizedBox(
            height: size.height * .01,
          ),
          Text(
            subTextCard != null ? '$subTextCard' : '',
            style:
                smallTitleStyleWhite,
          ),
        ],
      ),
    );
  }
}
