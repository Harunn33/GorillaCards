// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppBorderRadius {
  AppBorderRadius._();

  static final BorderRadius generalRadius = BorderRadius.circular(
    5.sp, // 8 e çekince release APK daki hata gidiyor-------------------5.sp
  );
}
