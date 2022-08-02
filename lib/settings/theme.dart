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
      color: Colors.black, fontSize: 24, fontWeight: FontWeight.w900);
}

TextStyle get smallTitleStyle {
  return TextStyle(
      color: Colors.black, fontSize: 18, fontWeight: FontWeight.w900);
}

TextStyle get subTitleStyle {
  return TextStyle(
      color: Colors.black, fontSize: 16, fontWeight: FontWeight.w900);
}

TextStyle get smalSubTitleStyle {
  return TextStyle(
      color: Colors.black, fontSize: 14, fontWeight: FontWeight.w900);
}
