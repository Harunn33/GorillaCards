import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninController extends GetxController {
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
}
