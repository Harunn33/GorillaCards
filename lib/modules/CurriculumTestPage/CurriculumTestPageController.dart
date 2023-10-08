// ignore_for_file: file_names

import 'package:card_swiper/card_swiper.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gorillacards/di.dart';
import 'package:gorillacards/models/CurriculumTestModel.dart';
import 'package:gorillacards/modules/Curriculum/CurruiculumController.dart';

class CurriculumTestPageController extends GetxController {
  RxString selectedChoice = "".obs;
  RxList<QuestionList> questionList = <QuestionList>[].obs;

  final FlipCardController flipCardController = FlipCardController();
  final SwiperController swiperController = SwiperController();
  final GetStorage storage = GetStorage();
  final CurriculumController curriculumController =
      Get.find<CurriculumController>();

  final parameters = Get.parameters;

  @override
  void onInit() {
    super.onInit();
    getQuestions();
  }

  Future<void> getQuestions() async {
    final list = await supabase
        .from("Curriculum")
        .select("question_list")
        .eq("level", parameters["level"]);

    for (var questions in list[0]["question_list"]) {
      final question = QuestionList.fromJson(questions);
      questionList.add(question);
    }
  }
}
