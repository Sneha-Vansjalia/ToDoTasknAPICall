// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ThemeClass {
  ThemeClass();
  static const Color whiteColor = Color(0xFFFFFFFF);

  static final Color blackColor = Color(0xFF000000);
  static final Color blackColor1 = Color(0xFF292929);

  static final Color greyColor = Color(0xFF757575);

  static final Color orangeColor = Color(0xFFF15A24);

  static final Color greenColor = Color(0xFF28B446);
  static final Color redColor = Color(0xFFDB0000);

  static final themeData = ThemeData(
    primaryColor: ThemeClass.orangeColor,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
  );
}
