// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomInputLabel extends StatelessWidget {
  const CustomInputLabel({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: AppColors.black,
          ),
    );
  }
}
