// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../shared/constants/borderRadius.dart';
import '../../../shared/constants/colors.dart';

class CustomFAB extends StatelessWidget {
  final void Function() onTap;
  final String title;
  final Color? bg;
  const CustomFAB(
      {super.key, required this.onTap, required this.title, this.bg});

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
      backgroundColor: bg ?? AppColors.primary,
      splashColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: AppBorderRadius.generalRadius,
      ),
      onPressed: onTap,
      label: Text(
        title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
