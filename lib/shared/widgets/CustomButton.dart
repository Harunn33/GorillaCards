// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:gorillacards/shared/constants/colors.dart';
import 'package:gorillacards/shared/constants/spacer.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final Color bg;
  final Color textColor;
  final bool isWide;
  final bool hasIcon;
  final IconData icon;
  RxBool? isLoading;
  CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.bg,
    required this.textColor,
    this.isWide = false,
    this.hasIcon = false,
    this.icon = Icons.add,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Container(
        width: isWide ? double.infinity : null,
        padding: EdgeInsets.symmetric(
          horizontal: 3.w,
          vertical: isWide ? 1.5.h : 1.h,
        ),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(
            isWide || hasIcon ? 5.sp : 20.sp,
          ),
        ),
        child: hasIcon
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: AppColors.white),
                  AppSpacer.w2,
                  Expanded(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: textColor),
                    ),
                  ),
                ],
              )
            : isLoading != null
                ? Obx(
                    () => isLoading?.value == true
                        ? Center(
                            child: LoadingAnimationWidget.staggeredDotsWave(
                              color: AppColors.white,
                              size: 16.sp,
                            ),
                          )
                        : Text(
                            text,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(color: textColor),
                          ),
                  )
                : Text(
                    text,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: textColor),
                  ),
      ),
    );
  }
}
