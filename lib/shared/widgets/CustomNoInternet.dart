// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:gorillacards/shared/enums/lottie.dart';
import 'package:sizer/sizer.dart';

class CustomNoInternet extends StatelessWidget {
  const CustomNoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: Center(
          child: SizedBox(
            width: 40.h,
            height: 40.h,
            child: CustomLottie.noInternet.lottieAsset,
          ),
        ),
      ),
    );
  }
}
