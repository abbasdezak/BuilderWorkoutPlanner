import 'package:flutter/material.dart';

import '../data.dart';

class RoundedInputField extends StatelessWidget {
  final double? widthSize;
  final TextEditingController? textControler;
  final String? hintText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const RoundedInputField({
    Key? key,
    this.hintText,
    this.textControler,
    this.widthSize,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(
      child: Container(
          margin: EdgeInsets.only(top: size.height * .015),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          height: size.height * .07,
          width: widthSize,
          decoration: BoxDecoration(
              color: Color(lightColor),
              borderRadius: BorderRadius.circular(20)),
          child: TextFormField(
              onChanged: onChanged,
              controller: textControler,
              decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                  hoverColor: Colors.black,
                  hintStyle: TextStyle(fontWeight: FontWeight.bold)),
              validator: validator)),
    );
  }
}
