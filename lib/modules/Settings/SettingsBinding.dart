// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:gorillacards/modules/Settings/SettingsController.dart';

class SettingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}
