// ignore_for_file: file_names

import 'package:card_swiper/card_swiper.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gorillacards/models/deckModel.dart';
import 'package:gorillacards/routes/app_pages.dart';

class FlashCardPageController extends GetxController {
  List<Content> flashCards = Get.arguments[0];
  List<Content> reports = <Content>[];
  RxInt index = 0.obs;
  RxInt correctAnswers = 0.obs;
  RxInt wrongAnswers = 0.obs;
  RxInt emptyAnswers = 0.obs;

  final FlipCardController flipCardController = FlipCardController();
  final SwiperController swiperController = SwiperController();
  final TextEditingController answerController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FocusNode answerFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    flashCards.shuffle();
  }

  @override
  void dispose() {
    super.dispose();
    flipCardController.state?.dispose();
    swiperController.dispose();
    answerController.dispose();
  }

  void checkAnswer(List<Content> flashCards) {
    final GetStorage box = GetStorage();
    final currentFlashCard = flashCards[index.value];
    final userAnswer = answerController.text.toLowerCase().trim();
    final correctAnswer = currentFlashCard.back.toLowerCase().trim();
    if (userAnswer.isEmpty) {
      emptyAnswers.value += 1;
      reports.add(currentFlashCard);
    } else if (userAnswer == correctAnswer) {
      correctAnswers.value += 1;
    } else {
      wrongAnswers.value += 1;
      reports.add(currentFlashCard);
    }

    if (index.value == flashCards.length - 1) {
      Get.toNamed(Routes.RESULT);
      box.write("reports", reports);
    } else {
      swiperController.next(); // Sonraki soruya ilerle
    }
  }
}
