import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomRichText extends StatelessWidget {
  final String firstText;
  final String secondText;
  final void Function() secondTextOnTap;
  const CustomRichText({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.secondTextOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: firstText,
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          TextSpan(
            text: secondText,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.primary,
                ),
            recognizer: TapGestureRecognizer()..onTap = secondTextOnTap,
          ),
        ],
      ),
    );
  }
}
