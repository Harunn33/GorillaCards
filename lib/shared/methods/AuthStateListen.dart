// ignore_for_file: file_names

import 'package:get/get.dart';
import '../../di.dart';
import '../../routes/app_pages.dart';

class AuthStateListen {
  static authStateListen() {
    return supabase.auth.onAuthStateChange.listen((event) {
      final session = event.session;
      if (session != null) {
        Get.offAllNamed(Routes.HOME);
      }
    });
  }
}
