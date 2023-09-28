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
import '../../shared/methods/AuthStateListen.dart';
import '../../shared/methods/CustomLoadingDialog.dart';

class SigninController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool passwordObscure = false.obs;
  RxBool isLoading = false.obs;

  late final StreamSubscription<AuthState> authSubscription;

  @override
  void onInit() {
    super.onInit();
    authSubscription = AuthStateListen.authStateListen();
  }

  @override
  void dispose() {
    super.dispose();
    authSubscription.cancel();
    emailController.dispose();
    passwordController.dispose();
  }

  void allFocusNodeUnfocus() {
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
  }

  Future<void> handleSignin() async {
    await Get.closeCurrentSnackbar();
    CustomLoadingDialog();
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
