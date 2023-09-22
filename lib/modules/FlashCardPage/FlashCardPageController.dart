// ignore_for_file: file_names

import 'package:flip_card/flip_card_controller.dart';
import 'package:get/get.dart';

class FlashCardPageController extends GetxController {
  RxString selectedChoice = "".obs;
  RxInt isSelectedIndex = (-1).obs;

  final FlipCardController flipCardController = FlipCardController();
}
