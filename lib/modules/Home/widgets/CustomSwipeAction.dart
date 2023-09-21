// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:sizer/sizer.dart';

import '../../../shared/constants/colors.dart';
import '../../../shared/constants/fonts.dart';

SwipeAction CustomSwipeAction({
  required String title,
  required IconData icon,
  required void Function() onTap,
  Color? color,
  bool hasHandler = false,
}) {
  return SwipeAction(
    forceAlignmentToBoundary: true,
    backgroundRadius: 6.sp,
    title: title,
    icon: Icon(
      icon,
      color: AppColors.white,
    ),
    style: TextStyle(
      fontSize: 10.sp,
      color: AppColors.white,
      fontFamily: AppFonts.medium,
    ),
    onTap: (CompletionHandler handler) async {
      hasHandler ? null : await handler(true);
      onTap();
    },
    color: color ?? AppColors.red,
  );
}
