// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
  RxBool buttonDisabled = false.obs;

  late final StreamSubscription<AuthState> authSubscription;

  final GetStorage box = GetStorage();

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

  Future<void> handleLogin() async {
    buttonDisabled.value = true;
    await Get.closeCurrentSnackbar();
    CustomLoadingDialog();
    try {
      await supabase.auth.signInWithPassword(
        password: passwordController.text.trim(),
        email: emailController.text.trim(),
      );
      buttonDisabled.value = false;
      Get.offAllNamed(Routes.HOME);
    } on AuthException catch (error) {
      buttonDisabled.value = false;
      Get.back();
      CustomSnackbar(
        title: AppStrings.error,
        message: error.message,
      );
    } catch (e) {
      buttonDisabled.value = false;
      Get.back();
      CustomSnackbar(
        title: AppStrings.error,
        message: AppStrings.invalidEmailOrPassword,
      );
    }
  }
}
