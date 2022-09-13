import 'package:builderworkoutplanner/app/core/values/theme.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {Key? key,
      required this.onTap,
      this.width,
      this.height,
      required this.text})
      : super(key: key);
  final Function() onTap;
  final double? width;
  final double? height;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 0, 97, 194),
              Color.fromARGB(255, 0, 69, 148),
              Color.fromARGB(255, 0, 59, 107),
              Color.fromARGB(255, 0, 49, 89),
            ]),
            borderRadius: BorderRadius.circular(2)),
        child: Center(
          child: Text(
            text,
            style: titleStyleWhite,
          ),
        ),
      ),
    );
  }
}
