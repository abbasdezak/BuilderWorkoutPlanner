import 'package:flutter/material.dart';

import '../data.dart';

class RoundedInputField extends StatelessWidget {
  final double? widthSize;
  final double? heightSize;
  final TextEditingController? textControler;
  final String? hintText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Color? color;

  const RoundedInputField({
    Key? key,
    this.hintText,
    this.textControler,
    this.widthSize,
    this.onChanged,
    this.validator,
    this.color,
    this.heightSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        margin: EdgeInsets.only(top: size.height * .015),
        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
        height: heightSize ?? size.height * .07,
        width: widthSize,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            SizedBox(
              width: size.width * .75,
              child: TextFormField(
                  onChanged: onChanged,
                  controller: textControler,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                  decoration: InputDecoration(
                      hintText: hintText,
                      border: InputBorder.none,
                      hoverColor: Colors.white,
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  validator: validator),
            ),
          ],
        ));
  }
}
