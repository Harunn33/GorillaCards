import 'package:flip_card/flip_card_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gorillacards/models/deckModel.dart';
import 'package:gorillacards/shared/constants/strings.dart';

import '../../shared/constants/colors.dart';
import '../FlashCardPage/FlashCardPageController.dart';

class ResultController extends GetxController {
  List<Content> reports = <Content>[];
  RxList results = [].obs;

  final FlipCardController flipCardController = FlipCardController();
  final FlashCardPageController flashCardPageController = Get.find();

  @override
  void dispose() {
    super.dispose();
    flipCardController.state?.dispose();
  }

  @override
  void onInit() async {
    super.onInit();
    final GetStorage storage = GetStorage();
    reports = await storage.read("reports");
    results.addAll([
      {
        "value": flashCardPageController.correctAnswers.value.toDouble(),
        "color": AppColors.dustyGreen,
        "title": AppStrings.numberOfCorrect,
      },
      {
        "value": flashCardPageController.wrongAnswers.value.toDouble(),
        "color": AppColors.red,
        "title": AppStrings.numberOfWrong,
      },
      {
        "value": flashCardPageController.emptyAnswers.value.toDouble(),
        "color": AppColors.santasGrey,
        "title": AppStrings.numberOfEmpty,
      },
    ]);
    results.refresh();
  }
}
