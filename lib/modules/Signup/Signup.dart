// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorillacards/modules/Signup/SignupController.dart';
import 'package:gorillacards/routes/app_pages.dart';
import 'package:gorillacards/shared/constants/colors.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import 'package:gorillacards/shared/constants/spacer.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/widgets/CustomButton.dart';

import '../../shared/widgets/CustomRichText.dart';
import '../../shared/widgets/CustomTextFormField.dart';

class Signup extends GetView<SignupController> {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignupController());
    return GestureDetector(
      onTap: () => controller.allFocusNodeUnfocus(),
      child: Scaffold(
        appBar: AppBar(),
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
                    AppStrings.signupTitle,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  AppSpacer.h3,
                  // Email
                  CustomTextFormField(
                    controller: controller.emailController,
                    focusNode: controller.emailFocusNode,
                    hintText: AppStrings.emailHint,
                    prefixIcon: Icons.email_outlined,
                    validator: (value) {
                      if (value == null) {
                        return null;
                      }
                      if (value.isEmpty) {
                        return AppStrings.emailBlankError;
                      } else if (!controller.emailRegex.hasMatch(value)) {
                        return AppStrings.emailNotValid;
                      }
                      return null;
                    },
                  ),
                  AppSpacer.h2,
                  // Password
                  Obx(
                    () => CustomTextFormField(
                      controller: controller.passwordController,
                      focusNode: controller.passwordFocusNode,
                      hintText: AppStrings.passwordHint,
                      prefixIcon: Icons.lock_outlined,
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
                  AppSpacer.h2,
                  // Password Again
                  Obx(
                    () => CustomTextFormField(
                      controller: controller.passwordAgainController,
                      focusNode: controller.passwordAgainFocusNode,
                      hintText: AppStrings.passwordAgainHint,
                      prefixIcon: Icons.lock_outlined,
                      isPassword: true,
                      isObscure: controller.passwordAgainObscure.value,
                      onTap: () {
                        controller.passwordAgainObscure.toggle();
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.passwordAgainBlankError;
                        } else if (value !=
                            controller.passwordController.text) {
                          return AppStrings.passwordAgainNotMatch;
                        }
                        return null;
                      },
                    ),
                  ),
                  AppSpacer.h3,
                  Obx(
                    () => CustomButton(
                      onTap: controller.buttonDisabled.value
                          ? null
                          : () {
                              controller.allFocusNodeUnfocus();
                              if (controller.formKey.currentState!.validate()) {
                                controller.handleSignup();
                              }
                            },
                      text: AppStrings.signup,
                      isWide: true,
                      bg: AppColors.primary,
                      textColor: AppColors.white,
                    ),
                  ),
                  AppSpacer.h2,
                  CustomRichText(
                    firstText: AppStrings.hasAccount,
                    secondText: AppStrings.signin,
                    secondTextOnTap: () {
                      Get.offNamed(Routes.SIGNIN);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
