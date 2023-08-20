// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gorillacards/data/model/SigninModel.dart';
import 'package:gorillacards/data/network/api/SigninApi.dart';
import 'package:gorillacards/routes/app_pages.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/methods/CustomSnackbar.dart';
import '../../shared/methods/CustomLoadingDialog.dart';

class SigninController extends GetxController {
  final SigninApi _signinApi = SigninApi();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool passwordObscure = false.obs;
  RxBool buttonDisabled = false.obs;

  final GetStorage box = GetStorage();

  void allFocusNodeUnfocus() {
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
  }

  Future<void> handleSignin() async {
    buttonDisabled.value = true;
    await Get.closeCurrentSnackbar();
    CustomLoadingDialog();
    final SigninModel signinModel = SigninModel(
      email: emailController.text,
      password: passwordController.text,
    );
    try {
      final response = await _signinApi.putSignin(data: signinModel.toJson());
      if (response.statusCode == 200) {
        buttonDisabled.value = false;
        box.write("token", response.data["token"]);
        Get.offAllNamed(Routes.HOME);
      }
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
