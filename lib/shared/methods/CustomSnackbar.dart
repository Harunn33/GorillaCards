// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';

enum SnackbarType {
  error,
  success,
}

SnackbarController CustomSnackbar({
  required String title,
  required String message,
  SnackbarType? type,
  void Function(GetSnackBar)? onTap,
}) {
  Color? bg;
  switch (type) {
    case SnackbarType.error:
      bg = AppColors.red;
    case SnackbarType.success:
      bg = AppColors.dustyGreen;
    default:
      bg = AppColors.red;
  }
  return Get.snackbar(
    title,
    message,
    backgroundColor: bg,
    onTap: onTap,
    colorText: AppColors.white,
  );
}
