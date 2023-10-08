// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:gorillacards/modules/CurriculumTestPage/CurriculumTestPageController.dart';

class CurriculumTestPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CurriculumTestPageController>(
        () => CurriculumTestPageController());
  }
}
