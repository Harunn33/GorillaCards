import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static Color black = const Color(0xFF000000);
  static Color white = const Color(0xFFFFFFFF);
  static Color primary = const Color(0xFF60A5FA);
  static Color dreamyCloud = const Color(0xFFE5E7EB);
  static Color drWhite = const Color(0xFFF9fAFB);
  static Color bellflowerBlue = const Color(0xFFE2E8F0);
  static Color santasGrey = const Color(0xFF9CA3AF);
  static Color red = const Color(0xFFFE0000);
  static Color dustyGreen = const Color(0xFF7AA874);
  static Color approvalGreen = const Color(0xFF009688);
  static Color brilliantAzure = const Color(0xFF33A1FF);
  static Color frozenLandscape = const Color(0xFFAEE0FF);
  static Color usafaBlue = const Color(0xFF004C99);
}

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}
