// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gorillacards/shared/enums/question_type.dart';

class CurriculumController extends GetxController {
  final GetStorage storage = GetStorage();

  RxInt currentStep = 0.obs;
  RxDouble progress = 1.0.obs;
  RxDouble translatePercent = 0.00.obs;
  RxDouble trueFalsePercent = 0.00.obs;

  List<String> questionTypeList = ["Translate Exercise"];
  List<bool> stepActiveStateList = [];

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
    for (var i = 0; i < 6; i++) {
      translatePercent.value = storage
              .read("${getQuestionLevel(i)}-${QuestionType.Translate.name}") ??
          0.0;
      trueFalsePercent.value = storage
              .read("${getQuestionLevel(i)}-${QuestionType.True_False.name}") ??
          0.0;
      if ((translatePercent.value + trueFalsePercent.value) / 2 >= 75) {
        currentStep.value += 1;
        stepActiveStateList.addAll([true, true]);
        stepActiveStateList[i + 1] = true;
        update();
      }
      stepActiveStateList.add(false);
    }
  }
}
