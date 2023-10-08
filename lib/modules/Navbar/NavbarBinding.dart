// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:gorillacards/modules/Navbar/NavbarController.dart';

class NavbarBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavbarController>(() => NavbarController());
  }
}
