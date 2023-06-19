import 'package:flutter/material.dart';

class ColorConstants {
  static const Color lightScaffoldBackgroundColor = Color(0xFFF5F8FE);
  static Color darkScaffoldBackgroundColor = hexToColor('#2F2E2E');
  static Color secondaryAppColor = Color(0xFF4470B4);
  static Color secondaryDarkAppColor = Colors.white;
  static Color tipColor = hexToColor('#B6B6B6');
  static Color lightGray = Color(0xFFF6F6F6);
  static Color darkGray = Color(0xFF9F9F9F);
  static Color black = Color(0xFF000000);
  static Color white = Color(0xFFFFFFFF);

  static const Color mainColor = Color(0xFF263990);
  static const Color secondaryColor = Color(0xFF061367);
  static const Color disableButton = Color.fromRGBO(200, 200, 200, 1.0);
  static Color backgroundTextField = hexToColor('#EDF0F4');

  static const Color borderColor = Color(0xFFf2f2f2);
  static const Color cardColor = Color(0xFFF9F9F9);
}

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}
