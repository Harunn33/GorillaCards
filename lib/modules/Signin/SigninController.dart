import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorillacards/data/network/api/SigninApi.dart';
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

  void allFocusNodeUnfocus() {
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
  }

  Future<void> handleSignin() async {
    CustomLoadingDialog();
    try {
      final response = await _signinApi.putSignin(data: {
        "email": emailController.text,
        "password": passwordController.text,
      });
      if (response.statusCode == 200) {
        Get.back();
      }
    } catch (e) {
      Get.back();
      CustomSnackbar();
    }
  }
}
