// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorillacards/controllers/NetworkController.dart';
import 'package:gorillacards/modules/Signup/SignupController.dart';
import 'package:gorillacards/routes/app_pages.dart';
import 'package:gorillacards/shared/constants/colors.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import 'package:gorillacards/shared/constants/spacer.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/widgets/CustomButton.dart';
import 'package:gorillacards/shared/widgets/CustomNoInternet.dart';

import '../../shared/widgets/CustomRichText.dart';
import '../../shared/widgets/CustomTextFormField.dart';

class Signup extends GetView<SignupController> {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignupController());
    return GetBuilder<NetworkController>(builder: (networkController) {
      if (networkController.connectionType.value == 0) {
        return const CustomNoInternet();
      }
      return Scaffold(
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
                    AppStrings.signupTitle.tr,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  AppSpacer.h3,
                  // Email
                  CustomTextFormField(
                    actionType: TextInputAction.next,
                    onTapOutside: (p0) => controller.allFocusNodeUnfocus(),
                    controller: controller.emailController,
                    focusNode: controller.emailFocusNode,
                    hintText: AppStrings.emailHint.tr,
                    prefixIcon: Icons.email_outlined,
                    validator: (value) {
                      if (value == null) {
                        return null;
                      }
                      if (value.isEmpty) {
                        return "* ${AppStrings.emailBlankError.tr}";
                      } else if (!controller.emailRegex.hasMatch(value)) {
                        return "* ${AppStrings.emailNotValid.tr}";
                      }
                      return null;
                    },
                  ),
                  AppSpacer.h2,
                  // Password
                  Obx(
                    () => CustomTextFormField(
                      actionType: TextInputAction.next,
                      onTapOutside: (p0) => controller.allFocusNodeUnfocus(),
                      controller: controller.passwordController,
                      focusNode: controller.passwordFocusNode,
                      hintText: AppStrings.passwordHint.tr,
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
                          return "* ${AppStrings.passwordBlankError.tr}";
                        } else if (value.length < 6) {
                          return "* ${AppStrings.passwordNotValid.tr}";
                        }
                        return null;
                      },
                    ),
                  ),
                  AppSpacer.h2,
                  // Password Again
                  Obx(
                    () => CustomTextFormField(
                      onSubmit: controller.isLoading.value
                          ? null
                          : (p0) {
                              controller.allFocusNodeUnfocus();
                              if (controller.formKey.currentState!.validate()) {
                                controller.isLoading.toggle();
                                controller.handleSignUp();
                              }
                              return null;
                            },
                      onTapOutside: (p0) => controller.allFocusNodeUnfocus(),
                      controller: controller.passwordAgainController,
                      focusNode: controller.passwordAgainFocusNode,
                      hintText: AppStrings.passwordAgainHint.tr,
                      prefixIcon: Icons.lock_outlined,
                      isPassword: true,
                      isObscure: controller.passwordAgainObscure.value,
                      onTap: () {
                        controller.passwordAgainObscure.toggle();
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "* ${AppStrings.passwordAgainBlankError.tr}";
                        } else if (value !=
                            controller.passwordController.text) {
                          return "* ${AppStrings.passwordAgainNotMatch.tr}";
                        }
                        return null;
                      },
                    ),
                  ),
                  AppSpacer.h3,
                  Obx(
                    () => CustomButton(
                      isLoading: controller.isLoading,
                      onTap: controller.isLoading.value
                          ? null
                          : () {
                              controller.allFocusNodeUnfocus();
                              if (controller.formKey.currentState!.validate()) {
                                controller.isLoading.toggle();
                                controller.handleSignUp();
                              }
                            },
                      text: AppStrings.signup.tr,
                      isWide: true,
                      bg: AppColors.primary,
                      textColor: AppColors.white,
                    ),
                  ),
                  AppSpacer.h2,
                  CustomRichText(
                    firstText: AppStrings.hasAccount.tr,
                    secondText: AppStrings.signin.tr,
                    secondTextOnTap: () {
                      Get.offNamed(Routes.SIGNIN);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
