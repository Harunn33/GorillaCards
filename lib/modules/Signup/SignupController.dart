// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorillacards/models/SignupModel.dart';
import 'package:gorillacards/routes/app_pages.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/methods/AuthStateListen.dart';
import 'package:gorillacards/shared/methods/CustomSnackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../di.dart';
import '../../shared/methods/CustomLoadingDialog.dart';

class SignupController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode passwordAgainFocusNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordAgainController = TextEditingController();

  final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  RxBool passwordObscure = false.obs;
  RxBool passwordAgainObscure = false.obs;
  RxBool isLoading = false.obs;

  late final StreamSubscription<AuthState> authSubscription;

  @override
  void onInit() {
    super.onInit();
    authSubscription = AuthStateListen.authStateListen();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordAgainController.dispose();
    passwordController.dispose();
    authSubscription.cancel();
    super.dispose();
  }

  void allFocusNodeUnfocus() {
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
    passwordAgainFocusNode.unfocus();
  }

  Future<void> handleSignUp() async {
    await Get.closeCurrentSnackbar();
    CustomLoadingDialog();
    final SignupModel signupModel = SignupModel(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
    try {
      await supabase.auth.signUp(
        password: signupModel.password,
        email: signupModel.email,
      );
      Get.offAllNamed(Routes.HOME);
    } on AuthException catch (error) {
      Get.back();
      CustomSnackbar(
        title: AppStrings.error,
        message: error.message,
      );
    } catch (e) {
      Get.back();
      CustomSnackbar(
        title: AppStrings.error,
        message: AppStrings.invalidEmailOrPassword,
      );
    }
  }
}
