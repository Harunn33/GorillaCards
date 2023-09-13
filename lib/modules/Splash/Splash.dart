// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorillacards/shared/constants/paddings.dart';

import '../../shared/enums/images.dart';
import 'SplashController.dart';

class Splash extends GetView<SplashController> {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: Padding(
        padding: AppPaddings.generalPadding,
        child: Center(child: Images.appLogo.png),
      ),
    );
  }
}
