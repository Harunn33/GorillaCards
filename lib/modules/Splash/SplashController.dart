// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gorillacards/routes/app_pages.dart';

class SplashController extends GetxController {
  final GetStorage box = GetStorage();
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
        if (box.read("token") != null)
          Get.offAllNamed(
            Routes.HOME,
          )
        else
          Get.toNamed(
            Routes.WELCOME,
          )
      };
}
