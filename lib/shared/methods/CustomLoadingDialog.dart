// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../constants/strings.dart';

Future<dynamic> CustomLoadingDialog() {
  return Get.defaultDialog(
    title: "",
    barrierDismissible: false,
    onWillPop: () async => false,
    content: Center(
      child: Lottie.asset(
        AppStrings.loadingPath,
      ),
    ),
  );
}
