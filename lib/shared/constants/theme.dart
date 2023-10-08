// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:gorillacards/shared/constants/borderRadius.dart';
import 'package:gorillacards/shared/constants/colors.dart';
import 'package:gorillacards/shared/constants/fonts.dart';
import 'package:sizer/sizer.dart';

ThemeData CustomTheme() {
  return ThemeData(
    colorSchemeSeed: AppColors.dustyGreen,
    scaffoldBackgroundColor: AppColors.white,
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      surfaceTintColor: AppColors.white,
      backgroundColor: AppColors.white,
    ),
    dialogBackgroundColor: AppColors.white,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.drWhite,
      filled: true,
      errorStyle: TextStyle(
        fontSize: 8.sp,
        fontFamily: AppFonts.medium,
        color: AppColors.red,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.red,
          width: .3.w,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.red,
          width: .3.w,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppBorderRadius.generalRadius,
        borderSide: BorderSide(
          color: AppColors.bellflowerBlue,
          width: .3.w,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.primary,
          width: .3.w,
        ),
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 25.sp,
        fontFamily: AppFonts.bold,
      ),
      headlineMedium: TextStyle(
        fontSize: 20.sp,
        fontFamily: AppFonts.bold,
      ),
      headlineSmall: TextStyle(
        fontSize: 16.sp,
        fontFamily: AppFonts.bold,
      ),
      bodyLarge: TextStyle(
        fontSize: 15.sp,
        fontFamily: AppFonts.medium,
      ),
      bodyMedium: TextStyle(
        fontSize: 11.6.sp,
        fontFamily: AppFonts.regular,
      ),
      labelMedium: TextStyle(
        fontSize: 12.sp,
        fontFamily: AppFonts.semibold,
        color: AppColors.white,
      ),
      titleMedium: TextStyle(
        fontSize: 11.sp,
        color: AppColors.black,
        fontFamily: AppFonts.medium,
      ),
      titleSmall: TextStyle(
        fontSize: 8.sp,
        color: AppColors.santasGrey,
        fontFamily: AppFonts.regular,
      ),
    ),
  );
}
