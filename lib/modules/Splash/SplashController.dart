// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:gorillacards/routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    goWelcome();
  }

  void goWelcome() async => {
        await Future.delayed(
          const Duration(
            seconds: 2,
          ),
        ),
        Get.toNamed(
          Routes.WELCOME,
        )
      };
}
