// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:gorillacards/modules/FlashCardPage/FlashCardPageController.dart';

class FlashCardPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FlashCardPageController>(() => FlashCardPageController());
  }
}
