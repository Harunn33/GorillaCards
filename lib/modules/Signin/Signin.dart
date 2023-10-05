// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:gorillacards/di.dart';
import 'package:gorillacards/modules/Signin/SigninController.dart';
import 'package:gorillacards/modules/Signup/SignupController.dart';
import 'package:gorillacards/routes/app_pages.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import 'package:gorillacards/shared/constants/spacer.dart';
import 'package:gorillacards/shared/widgets/CustomRichText.dart';
import 'package:gorillacards/shared/widgets/CustomTextButton.dart';
import 'package:gorillacards/shared/widgets/CustomTextFormField.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../shared/constants/colors.dart';
import '../../shared/constants/strings.dart';
import '../../shared/widgets/CustomButton.dart';

class Signin extends GetView<SigninController> {
  final SignupController signupController = SignupController();
  Signin({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SigninController());
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
                  AppStrings.signinTitle.tr,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                AppSpacer.h3,
                CustomTextFormField(
                  actionType: TextInputAction.next,
                  onTapOutside: (p0) => controller.allFocusNodeUnfocus(),
                  hintText: AppStrings.emailHint.tr,
                  prefixIcon: Icons.email_outlined,
                  focusNode: controller.emailFocusNode,
                  controller: controller.emailController,
                  validator: (value) {
                    if (value == null) {
                      return null;
                    }
                    if (value.isEmpty) {
                      return "* ${AppStrings.emailBlankError.tr}";
                    } else if (!signupController.emailRegex.hasMatch(value)) {
                      return "* ${AppStrings.emailNotValid.tr}";
                    }
                    return null;
                  },
                ),
                AppSpacer.h2,
                Obx(
                  () => CustomTextFormField(
                    onSubmit: controller.isLoading.value
                        ? null
                        : (p0) {
                            controller.allFocusNodeUnfocus();
                            if (controller.formKey.currentState!.validate()) {
                              controller.isLoading.toggle();
                              controller.handleSignin();
                            }
                            return null;
                          },
                    onTapOutside: (p0) => controller.allFocusNodeUnfocus(),
                    hintText: AppStrings.passwordHint.tr,
                    prefixIcon: Icons.lock_outlined,
                    focusNode: controller.passwordFocusNode,
                    controller: controller.passwordController,
                    isPassword: true,
                    isObscure: controller.passwordObscure.value,
                    onTap: () => controller.passwordObscure.toggle(),
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
                AppSpacer.h1,
                Bounceable(
                  onTap: () async {
                    controller.signInWithGoogle();

                    // await supabase.auth
                    //     .resetPasswordForEmail("humann210@gmail.com");
                  },
                  child: const Text("Şifremi Unuttum"),
                ),
                AppSpacer.h3,
                Obx(
                  () => CustomButton(
                    isLoading: controller.isLoading,
                    onTap: controller.isLoading.value
                        ? null
                        : () async {
                            controller.allFocusNodeUnfocus();
                            if (controller.formKey.currentState!.validate()) {
                              controller.isLoading.toggle();
                              controller.handleSignin();
                            }
                          },
                    text: AppStrings.signin.tr,
                    isWide: true,
                    bg: AppColors.primary,
                    textColor: AppColors.white,
                  ),
                ),
                AppSpacer.h2,
                CustomRichText(
                  firstText: AppStrings.dontHaveAccount.tr,
                  secondText: AppStrings.signup.tr,
                  secondTextOnTap: () => Get.offNamed(Routes.SIGNUP),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
