// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import '../constants/colors.dart';

class CustomModalBottomSheetTextFormField extends StatelessWidget {
  final String hintText;
  final FocusNode focusNode;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? Function(String)? submit;
  final bool isDescription;
  final void Function(PointerDownEvent)? onTapOutside;
  final TextInputAction? actionType;
  final bool autoFocus;
  const CustomModalBottomSheetTextFormField({
    super.key,
    required this.hintText,
    required this.focusNode,
    required this.controller,
    this.validator,
    this.isDescription = false,
    this.onTapOutside,
    this.actionType,
    this.submit,
    this.autoFocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autoFocus,
      onTapOutside: onTapOutside,
      cursorColor: AppColors.black,
      focusNode: focusNode,
      minLines: isDescription ? 4 : 1,
      maxLines: isDescription ? 8 : 1,
      controller: controller,
      validator: validator,
      textInputAction: actionType,
      onFieldSubmitted: submit,
      style: Theme.of(context).textTheme.titleMedium,
      decoration: InputDecoration(
        hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.santasGrey,
            ),
        hintText: hintText,
        contentPadding: AppPaddings.h3v1Padding,
      ),
    );
  }
}
