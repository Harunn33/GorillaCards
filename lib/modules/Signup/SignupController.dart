// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gorillacards/data/model/signupModel.dart';
import 'package:gorillacards/data/network/api/SignupApi.dart';
import 'package:gorillacards/routes/app_pages.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/methods/CustomSnackbar.dart';

import '../../shared/methods/CustomLoadingDialog.dart';

class SignupController extends GetxController {
  final SignupApi _signupApi = SignupApi();

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

  final GetStorage box = GetStorage();

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    passwordAgainFocusNode.dispose();
    super.dispose();
  }

  void allFocusNodeUnfocus() {
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
    passwordAgainFocusNode.unfocus();
  }

  Future<void> handleSignup() async {
    buttonDisabled.value = true;
    await Get.closeCurrentSnackbar();
    CustomLoadingDialog();
    final SignupModel signupModel = SignupModel(
      email: emailController.text,
      password: passwordController.text,
      repassword: passwordAgainController.text,
    );
    try {
      final response = await _signupApi.postSignup(data: signupModel.toJson());
      if (response.statusCode == 201) {
        buttonDisabled.value = false;
        box.write("token", response.data["token"]);
        CustomSnackbar(
          message: AppStrings.successRegistered,
          title: AppStrings.success,
          type: SnackbarType.success,
        );
        Get.offAllNamed(Routes.HOME);
      }
    } catch (e) {
      buttonDisabled.value = false;
      Get.back();
      CustomSnackbar(
        message: AppStrings.emailAlreadyExists,
        title: AppStrings.error,
      );
    }
  }
}
