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
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    passwordAgainFocusNode.dispose();
    emailController.dispose();
    passwordAgainController.dispose();
    passwordController.dispose();
    _authSubscription.cancel();
    super.dispose();
  }

  void allFocusNodeUnfocus() {
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
    passwordAgainFocusNode.unfocus();
  }

  Future<void> handleSignUp() async {
    buttonDisabled.value = true;
    await Get.closeCurrentSnackbar();
    CustomLoadingDialog();
    try {
      await supabase.auth.signUp(
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

  // Future<void> handleSignup() async {
  //   buttonDisabled.value = true;
  //   await Get.closeCurrentSnackbar();
  //   CustomLoadingDialog();
  //   final SignupModel signupModel = SignupModel(
  //     email: emailController.text,
  //     password: passwordController.text,
  //     repassword: passwordAgainController.text,
  //   );
  //   try {
  //     final response = await _signupApi.postSignup(data: signupModel.toJson());
  //     if (response.statusCode == 201) {
  //       buttonDisabled.value = false;
  //       box.write("token", response.data["token"]);
  //       CustomSnackbar(
  //         message: AppStrings.successRegistered,
  //         title: AppStrings.success,
  //         type: SnackbarType.success,
  //       );
  //       Get.offAllNamed(Routes.HOME);
  //     }
  //   } catch (e) {
  //     buttonDisabled.value = false;
  //     Get.back();
  //     CustomSnackbar(
  //       message: AppStrings.emailAlreadyExists,
  //       title: AppStrings.error,
  //     );
  //   }
  // }
}
