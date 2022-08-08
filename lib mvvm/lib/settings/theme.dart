import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Theme {
  final Size size;

  Theme({required this.size});
}

TextStyle get bigTitleStyle {
  return TextStyle(
      color: Colors.black, fontSize: 28, fontWeight: FontWeight.w900);
}

TextStyle get titleStyle {
  return TextStyle(
      color: Colors.black, fontSize: 22, fontWeight: FontWeight.w900);
}

TextStyle get titleStyleWhite {
  return TextStyle(
      color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900);
}

TextStyle get smallTitleStyle {
  return TextStyle(
      color: Colors.black, fontSize: 18, fontWeight: FontWeight.w900);
}

TextStyle get smallTitleStyleGrey {
  return TextStyle(
      color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w900);
}

TextStyle get subTitleStyle {
  return TextStyle(
      color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900);
}
TextStyle get subTitleStyleGrey {
  return TextStyle(
      color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w900);
}

TextStyle get smalSubTitleStyle {
  return TextStyle(
      color: Colors.black, fontSize: 14, fontWeight: FontWeight.w900);
}
