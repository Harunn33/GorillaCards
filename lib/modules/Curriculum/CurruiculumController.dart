// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CurriculumController extends GetxController {
  final GetStorage storage = GetStorage();

  RxInt currentStep = 0.obs;
  RxDouble progress = 1.0.obs;

  List<String> questionTypeList = ["Translate Exercise"];

  @override
  void onInit() {
    super.onInit();
    getCurrentStep();
  }

  String getQuestionLevel(int index) {
    switch (index) {
      case 0:
        return "A1";
      case 1:
        return "A2";
      case 2:
        return "B1";
      case 3:
        return "B2";
      case 4:
        return "C1";
      case 5:
        return "C2";
      default:
    }
    return "";
  }

  void getCurrentStep() {
    if (storage.read("A1") ?? false) {
      currentStep.value = 1;
      update();
    }
    if (storage.read("A2") ?? false) {
      currentStep.value = 2;
      update();
    }
    if (storage.read("B1") ?? false) {
      currentStep.value = 3;
      update();
    }
    if (storage.read("B2") ?? false) {
      currentStep.value = 4;
      update();
    }
    if (storage.read("C1") ?? false) {
      currentStep.value = 5;
      update();
    }
    if (storage.read("C2") ?? false) {
      currentStep.value = 6;
      update();
    }
  }
}
