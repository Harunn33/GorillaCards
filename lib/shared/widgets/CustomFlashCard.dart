// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:gorillacards/shared/constants/borderRadius.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';
import '../constants/imagePath.dart';
import '../constants/paddings.dart';

class CustomFlashCard extends StatelessWidget {
  final Widget child;
  const CustomFlashCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Container(
        padding: AppPaddings.generalPadding.copyWith(
          top: 2.h,
          bottom: 2.h,
        ),
        decoration: BoxDecoration(
          borderRadius: AppBorderRadius.generalRadius,
          color: AppColors.drWhite,
          image: const DecorationImage(
            image: AssetImage(
              ImagePaths.appLogo,
            ),
            opacity: .15,
            repeat: ImageRepeat.repeat,
          ),
        ),
        child: child,
      ),
    );
  }
}
