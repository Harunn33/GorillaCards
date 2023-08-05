// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final Color bg;
  final Color textColor;
  final bool isWide;
  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.bg,
    required this.textColor,
    this.isWide = false,
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
            isWide ? 5.sp : 20.sp,
          ),
        ),
        child: Text(
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
