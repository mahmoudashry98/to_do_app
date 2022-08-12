import 'package:flutter/material.dart';

class AppColors {
  static MaterialColor primaryColor = Colors.green;
  static Color textWhite = Colors.white;
  static Color textBlack = Colors.black;
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
