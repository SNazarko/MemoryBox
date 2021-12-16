import 'package:flutter/material.dart';
// class Color{
//   static const colorAppbar = '0xFF8C84E2';
//   static const colorText = '0xFF3A3A55';
// }

const kColorAppbar = Color(0xFF8C84E2);
const kColorText = Color(0xFF3A3A55);
const kTitleTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 48,
  fontFamily: 'TTNorms',
  fontWeight: FontWeight.bold,
);
const kTitle2TextStyle = TextStyle(
  fontFamily: 'TTNorms',
  fontSize: 14,
  color: Colors.white,
);
const kBottombarTextStyle = TextStyle(fontSize: 10, color: Color(0xFF3A3A55));
const kBorderContainer = BoxDecoration(
    color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20)));
const kBorderContainer2 = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    ));
