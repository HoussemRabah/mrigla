import 'package:flutter/material.dart';

Color colorBack = Color(0xFFFBF8F1);
Color colorForce = Color(0xFFF7ECDE);
Color colorForceBold = Color(0xFFE9DAC1);
Color colorMain = Color(0xff54BAB9);
Color colorWhite = Color(0xFFFFFFFF);
Color colorBlack = Color(0xFF000000);
Color colorRed = Color(0xFFF99C9C);

const TextStyle textStyleSmall = TextStyle(fontSize: 13.0);
const TextStyle textStyleSimple = TextStyle(fontSize: 15.0);
const TextStyle textStyleBig =
    TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500);
const TextStyle textStyleTitle =
    TextStyle(fontSize: 30.0, fontWeight: FontWeight.w900);

BoxShadow shadows = BoxShadow(
    offset: Offset(0, 0),
    blurRadius: 15.0,
    spreadRadius: 0,
    color: colorForceBold);

const BorderRadius borderRadius = BorderRadius.all(Radius.circular(30.0));

call() {
  print('calling');
}

maps() {
  print('maps');
}
