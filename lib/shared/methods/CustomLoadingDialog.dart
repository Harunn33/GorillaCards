// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../constants/strings.dart';

Future<dynamic> CustomLoadingDialog() {
  return Get.defaultDialog(
    title: "",
    backgroundColor: Colors.transparent,
    content: Center(
        child: Lottie.asset(
      AppStrings.loadingPath,
      width: 35.h,
      height: 35.h,
    )),
    barrierDismissible: false,
  );
}
