// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:gorillacards/routes/app_pages.dart';

import '../../di.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    redirect();
  }

  void redirect() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );
    final session = supabase.auth.currentSession;
    if (session != null) {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.toNamed(Routes.WELCOME);
    }
  }
}
