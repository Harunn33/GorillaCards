// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:gorillacards/shared/constants/colors.dart';
import 'package:gorillacards/shared/constants/fonts.dart';
import 'package:sizer/sizer.dart';

ThemeData CustomTheme() {
  return ThemeData(
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
        fontSize: 10.sp,
        fontFamily: AppFonts.semibold,
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
        borderRadius: BorderRadius.circular(5.sp),
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
        fontSize: 30.sp,
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
        fontSize: 18.sp,
        fontFamily: AppFonts.medium,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
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
    ),
  );
}
