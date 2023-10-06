// ignore_for_file: file_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:gorillacards/controllers/NetworkController.dart';
import 'package:gorillacards/modules/Signin/SigninController.dart';
import 'package:gorillacards/modules/Signup/SignupController.dart';
import 'package:gorillacards/routes/app_pages.dart';
import 'package:gorillacards/shared/constants/borderRadius.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import 'package:gorillacards/shared/constants/spacer.dart';
import 'package:gorillacards/shared/enums/images.dart';
import 'package:gorillacards/shared/widgets/CustomNoInternet.dart';
import 'package:gorillacards/shared/widgets/CustomRichText.dart';
import 'package:gorillacards/shared/widgets/CustomTextFormField.dart';
import 'package:sizer/sizer.dart';

import '../../shared/constants/colors.dart';
import '../../shared/constants/strings.dart';
import '../../shared/widgets/CustomButton.dart';

class Signin extends GetView<SigninController> {
  final SignupController signupController = SignupController();
  Signin({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SigninController());
    final NetworkController networkController = Get.put(NetworkController());
    return GetBuilder<NetworkController>(builder: (builder) {
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
                    onTap: () {
                      // await supabase.auth
                      //     .resetPasswordForEmail("humann210@gmail.com");
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Şifremi Unuttum",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: AppColors.primary),
                      ),
                    ),
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
                  ),
                  Platform.isAndroid ? AppSpacer.h3 : const SizedBox.shrink(),
                  Platform.isAndroid
                      ? Center(
                          child: Bounceable(
                            onTap: () => controller.handleGoogleSignin(),
                            child: Container(
                              padding: AppPaddings.h3v1Padding,
                              decoration: BoxDecoration(
                                color: AppColors.santasGrey.withOpacity(.15),
                                borderRadius: AppBorderRadius.generalRadius,
                              ),
                              width: 7.h,
                              height: 7.h,
                              child: Images.google.png,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
