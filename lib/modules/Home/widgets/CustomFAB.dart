// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../shared/constants/borderRadius.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/constants/strings.dart';

class CustomFAB extends StatelessWidget {
  final void Function() onTap;
  const CustomFAB({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      icon: Icon(
        Icons.add,
        color: AppColors.white,
      ),
      extendedPadding: EdgeInsets.symmetric(
        horizontal: 2.w,
      ),
      backgroundColor: AppColors.primary,
      splashColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: AppBorderRadius.generalRadius,
      ),
      onPressed: onTap,
      label: Text(
        AppStrings.addDeck,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
