import 'package:get/get.dart';
import 'package:gorillacards/di.dart';
import 'package:gorillacards/routes/app_pages.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/methods/CustomSnackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsController extends GetxController {
  RxBool isLoading = false.obs;
  Future<void> handleSignOut() async {
    try {
      await Get.closeCurrentSnackbar();
      await supabase.auth.signOut();
      Get.offAllNamed(Routes.WELCOME);
    } on AuthException catch (error) {
      isLoading.toggle();
      CustomSnackbar(
        title: AppStrings.error,
        message: error.message,
      );
    }
  }
}
