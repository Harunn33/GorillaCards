// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorillacards/shared/enums/lottie.dart';

Future<dynamic> CustomLoadingDialog() {
  return Get.defaultDialog(
    title: "",
    barrierDismissible: false,
    onWillPop: () async => false,
    content: Center(
      child: CustomLottie.loading.lottieAsset,
    ),
  );
}
