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
  final void Function(PointerDownEvent)? onTapOutside;
  final TextInputAction? actionType;
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
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.titleMedium,
      onTapOutside: onTapOutside,
      cursorColor: AppColors.black,
      cursorHeight: 2.h,
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
        contentPadding: EdgeInsets.symmetric(
          horizontal: 3.w,
          vertical: .5.h,
        ),
      ),
    );
  }
}
