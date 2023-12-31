// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import '../constants/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;
  final bool isObscure;
  final void Function()? onTap;
  final FocusNode focusNode;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(PointerDownEvent)? onTapOutside;
  final TextInputAction? actionType;
  final String? Function(String)? onSubmit;
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
    this.isObscure = false,
    this.onTap,
    required this.focusNode,
    required this.controller,
    this.validator,
    this.onTapOutside,
    this.actionType,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onSubmit,
      style: Theme.of(context).textTheme.titleMedium,
      onTapOutside: onTapOutside,
      cursorColor: AppColors.black,
      focusNode: focusNode,
      controller: controller,
      validator: validator,
      textInputAction: actionType,
      obscureText: isPassword ? !isObscure : false,
      decoration: InputDecoration(
        suffixIcon: isPassword
            ? Bounceable(
                onTap: onTap,
                child: Icon(
                  isObscure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.santasGrey,
                ),
              )
            : null,
        prefixIcon: Icon(
          prefixIcon,
          color: AppColors.santasGrey,
        ),
        hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.santasGrey,
            ),
        hintText: hintText,
        contentPadding: AppPaddings.h3v1Padding,
      ),
    );
  }
}
