// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:gorillacards/modules/Curriculum/CurruiculumController.dart';

class CurriculumBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CurriculumController>(() => CurriculumController());
  }
}
