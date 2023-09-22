// ignore_for_file: file_names

import 'package:card_swiper/card_swiper.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorillacards/models/deckModel.dart';
import 'package:gorillacards/shared/methods/CustomSnackbar.dart';

class FlashCardPageController extends GetxController {
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
  void dispose() {
    super.dispose();
    flipCardController.state?.dispose();
    swiperController.dispose();
    answerController.dispose();
  }

  void checkAnswer(List<Content> flashCards) {
    final currentFlashCard = flashCards[index.value];
    final userAnswer = answerController.text.toLowerCase();
    final correctAnswer = currentFlashCard.back.toLowerCase();
    if (userAnswer.isEmpty) {
      emptyAnswers.value += 1;
    } else if (userAnswer == correctAnswer) {
      correctAnswers.value += 1;
    } else {
      wrongAnswers.value += 1;
    }

    if (index.value == flashCards.length - 1) {
      Get.back();
      CustomSnackbar(
        title: "Sınav bitti gardaş",
        message:
            "Sınavını bitirdin hadi hayırlı olsun.\nDoğru sayısı: $correctAnswers\nYanlış sayısı: $wrongAnswers\nBoş sayısı: $emptyAnswers",
        type: SnackbarType.success,
      );
    } else {
      swiperController.next(); // Sonraki soruya ilerle
    }
  }
}
