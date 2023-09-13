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
import '../../shared/methods/CustomLoadingDialog.dart';

class SigninController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool passwordObscure = false.obs;
  RxBool buttonDisabled = false.obs;

  late final StreamSubscription<AuthState> _authSubscription;

  final GetStorage box = GetStorage();

  @override
  void onInit() {
    super.onInit();

    _authSubscription = supabase.auth.onAuthStateChange.listen((event) {
      final session = event.session;
      if (session != null) {
        Get.offAllNamed(Routes.HOME);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _authSubscription.cancel();
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

  // Future<void> handleSignin() async {
  //   buttonDisabled.value = true;
  //   await Get.closeCurrentSnackbar();
  //   CustomLoadingDialog();
  //   final SigninModel signinModel = SigninModel(
  //     email: emailController.text,
  //     password: passwordController.text,
  //   );
  //   try {
  //     final response = await _signinApi.putSignin(data: signinModel.toJson());
  //     if (response.statusCode == 200) {
  //       buttonDisabled.value = false;
  //       box.write("token", response.data["token"]);
  //       Get.offAllNamed(Routes.HOME);
  //     }
  //   } catch (e) {
  //     buttonDisabled.value = false;
  //     Get.back();
  //     CustomSnackbar(
  //       title: AppStrings.error,
  //       message: AppStrings.invalidEmailOrPassword,
  //     );
  //   }
  // }
}
