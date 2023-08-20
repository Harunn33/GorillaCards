// ignore_for_file: file_names

import 'package:get/get.dart';

import 'SigninController.dart';

class SigninBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SigninController>(() => SigninController());
  }
}
