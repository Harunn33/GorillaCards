import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorillacards/modules/Signin/SigninController.dart';
import 'package:gorillacards/modules/Signup/SignupController.dart';
import 'package:gorillacards/routes/app_pages.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import 'package:gorillacards/shared/constants/spacer.dart';
import 'package:gorillacards/shared/widgets/CustomRichText.dart';
import 'package:gorillacards/shared/widgets/CustomTextFormField.dart';

import '../../shared/constants/colors.dart';
import '../../shared/constants/strings.dart';
import '../../shared/widgets/CustomButton.dart';

class Signin extends GetView<SigninController> {
  final SignupController signupController = SignupController();
  Signin({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SigninController());
    return GestureDetector(
      onTap: () => controller.allFocusNodeUnfocus(),
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: AppColors.white,
          backgroundColor: AppColors.white,
        ),
        body: Container(
          alignment: Alignment.center,
          padding: AppPaddings.generalPadding,
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.signinTitle,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  AppSpacer.h3,
                  CustomTextFormField(
                    hintText: AppStrings.emailHint,
                    prefixIcon: Icons.email_outlined,
                    focusNode: controller.emailFocusNode,
                    controller: controller.emailController,
                    validator: (value) {
                      if (value == null) {
                        return null;
                      }
                      if (value.isEmpty) {
                        return AppStrings.emailBlankError;
                      } else if (!signupController.emailRegex.hasMatch(value)) {
                        return AppStrings.emailNotValid;
                      }
                      return null;
                    },
                  ),
                  AppSpacer.h2,
                  Obx(
                    () => CustomTextFormField(
                      hintText: AppStrings.passwordHint,
                      prefixIcon: Icons.lock_outlined,
                      focusNode: controller.passwordFocusNode,
                      controller: controller.passwordController,
                      isPassword: true,
                      isObscure: controller.passwordObscure.value,
                      onTap: () {
                        controller.passwordObscure.toggle();
                      },
                      validator: (value) {
                        if (value == null) {
                          return null;
                        }
                        if (value.isEmpty) {
                          return AppStrings.passwordBlankError;
                        } else if (value.length < 6) {
                          return AppStrings.passwordNotValid;
                        }
                        return null;
                      },
                    ),
                  ),
                  AppSpacer.h3,
                  CustomButton(
                    onTap: () {
                      controller.allFocusNodeUnfocus();
                      if (controller.formKey.currentState!.validate()) {
                        controller.handleSignin();
                      }
                    },
                    text: AppStrings.signin,
                    isWide: true,
                    bg: AppColors.primary,
                    textColor: AppColors.white,
                  ),
                  AppSpacer.h2,
                  CustomRichText(
                    firstText: AppStrings.dontHaveAccount,
                    secondText: AppStrings.signup,
                    secondTextOnTap: () => Get.offNamed(Routes.SIGNUP),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
