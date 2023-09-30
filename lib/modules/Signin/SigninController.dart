// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorillacards/models/SigninModel.dart';
import 'package:gorillacards/routes/app_pages.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/methods/CustomSnackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../di.dart';

class SigninController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool passwordObscure = false.obs;
  RxBool isLoading = false.obs;

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }

  void allFocusNodeUnfocus() {
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
  }

  Future<void> handleSignin() async {
    Get.closeAllSnackbars();
    final SigninModel signinModel = SigninModel(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
    try {
      await supabase.auth.signInWithPassword(
        password: signinModel.password,
        email: signinModel.email,
      );
      Get.offAllNamed(Routes.HOME);
    } on AuthException catch (error) {
      isLoading.toggle();
      CustomSnackbar(
        title: AppStrings.error.tr,
        message: error.message,
      );
    } catch (e) {
      isLoading.toggle();
      CustomSnackbar(
        title: AppStrings.error.tr,
        message: AppStrings.invalidEmailOrPassword.tr,
      );
    }
  }
}
