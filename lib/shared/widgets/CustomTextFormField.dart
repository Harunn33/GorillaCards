import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:sizer/sizer.dart';

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
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.black,
      cursorHeight: 3.h,
      focusNode: focusNode,
      controller: controller,
      validator: validator,
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
        contentPadding: EdgeInsets.symmetric(
          horizontal: 3.w,
          vertical: 1.5.h,
        ),
      ),
    );
  }
}
