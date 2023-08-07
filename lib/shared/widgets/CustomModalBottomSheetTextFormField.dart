import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';

class CustomModalBottomSheetTextFormField extends StatelessWidget {
  final String hintText;
  final FocusNode focusNode;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool isDescription;
  const CustomModalBottomSheetTextFormField({
    super.key,
    required this.hintText,
    required this.focusNode,
    required this.controller,
    this.validator,
    this.isDescription = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.black,
      cursorHeight: 3.h,
      focusNode: focusNode,
      minLines: isDescription ? 4 : 1,
      maxLines: isDescription ? 8 : 2,
      controller: controller,
      validator: validator,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.black,
          ),
      decoration: InputDecoration(
        hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.santasGrey,
            ),
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 3.w,
          vertical: .5.h,
        ),
      ),
    );
  }
}
