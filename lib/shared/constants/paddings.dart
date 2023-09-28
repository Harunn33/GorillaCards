import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppPaddings {
  AppPaddings._();

  static const EdgeInsets generalPadding = EdgeInsets.symmetric(
    horizontal:
        20, // 20 ye çekince release APK daki hata gidiyor---------------------5.w
  );
  static final EdgeInsets h3v1Padding = EdgeInsets.symmetric(
    horizontal: 3.w,
    vertical: 1.h,
  );
}
