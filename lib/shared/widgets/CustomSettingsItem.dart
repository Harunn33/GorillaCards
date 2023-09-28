// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:gorillacards/shared/constants/fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

import '../constants/borderRadius.dart';
import '../constants/colors.dart';
import '../constants/paddings.dart';

class CustomSettingsItem extends StatelessWidget {
  final void Function() onTap;
  final String title;
  final IconData icon;
  final Color? color;
  final Color? icColor;
  final Color? textColor;
  RxBool? isLoading;
  CustomSettingsItem({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
    this.color,
    this.icColor,
    this.textColor,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Container(
        padding: AppPaddings.h3v1Padding,
        decoration: BoxDecoration(
          borderRadius: AppBorderRadius.generalRadius,
          color: color ?? AppColors.dreamyCloud,
        ),
        child: isLoading == null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontFamily: AppFonts.medium,
                        color: textColor ?? AppColors.black),
                  ),
                  Icon(
                    icon,
                    color: icColor ?? AppColors.black,
                  )
                ],
              )
            : Obx(
                () => isLoading?.value == true
                    ? Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                            color: AppColors.primary, size: 15.sp),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontFamily: AppFonts.medium,
                                    color: textColor ?? AppColors.black),
                          ),
                          Icon(
                            icon,
                            color: icColor ?? AppColors.black,
                          )
                        ],
                      ),
              ),
      ),
    );
  }
}
