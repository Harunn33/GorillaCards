// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:gorillacards/shared/methods/AuthStateListen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    redirect();
  }

  void redirect() async {
    await Future.delayed(
      const Duration(
        seconds: 1,
      ),
    );
    AuthStateListen.authStateListen();
  }
}
