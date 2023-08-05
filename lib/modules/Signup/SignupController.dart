// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  @override
  void onInit() {
    super.onInit();
    print("Signup");
  }

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
}
