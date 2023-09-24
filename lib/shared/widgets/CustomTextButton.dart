// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:gorillacards/shared/constants/colors.dart';

class CustomTextButton extends StatelessWidget {
  final void Function() onTap;
  final String title;
  const CustomTextButton({
    super.key,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.primary,
            ),
      ),
    );
  }
}
