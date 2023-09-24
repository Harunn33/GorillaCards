import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppPaddings {
  AppPaddings._();

  static final EdgeInsets generalPadding = EdgeInsets.symmetric(
    horizontal: 5.w, // 20 ye çekince release APK daki hata gidiyor
  );
  static final EdgeInsets h3v1Padding = EdgeInsets.symmetric(
    horizontal: 3.w,
    vertical: 1.h,
  );
}
