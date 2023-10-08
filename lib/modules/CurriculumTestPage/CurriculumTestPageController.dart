// ignore_for_file: file_names

import 'package:card_swiper/card_swiper.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gorillacards/di.dart';
import 'package:gorillacards/models/CurriculumTestModel.dart';

class CurriculumTestPageController extends GetxController {
  RxString selectedChoice = "".obs;
  RxList<CurriculumTestModel> questions = <CurriculumTestModel>[].obs;

  final FlipCardController flipCardController = FlipCardController();
  final SwiperController swiperController = SwiperController();
  final GetStorage storage = GetStorage();

  final parameters = Get.parameters;

  @override
  void onInit() {
    super.onInit();
    getQuestions();
  }

  Future<void> getQuestions() async {
    final list = await supabase
        .from("Curriculum")
        .select()
        .eq("level", parameters["level"]);

    for (var question in list) {
      final deneme = CurriculumTestModel.fromJson(question);
      questions.add(deneme);
    }
  }
}
