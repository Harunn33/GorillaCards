// ignore_for_file: file_names

import 'package:get/get.dart';

import 'WelcomeController.dart';

class WelcomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WelcomeController>(
      () => WelcomeController(),
    );
  }
}
