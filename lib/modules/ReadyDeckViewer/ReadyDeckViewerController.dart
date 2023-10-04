// ignore_for_file: file_names

import 'package:flip_card/flip_card_controller.dart';
import 'package:get/get.dart';
import 'package:gorillacards/models/deckModel.dart';

class ReadyDeckViewerController extends GetxController {
  final args = Get.arguments;

  final FlipCardController flipCardController = FlipCardController();

  RxInt pageIndex = 0.obs;
  RxList<Content> flashCards = <Content>[].obs;

  @override
  void onInit() {
    super.onInit();
    getFlashCards();
  }

  void getFlashCards() {
    for (var card in args[0]) {
      flashCards.add(card);
    }
  }
}
