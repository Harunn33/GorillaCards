// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:gorillacards/modules/DeckDetail/DeckDetailController.dart';

class DeckDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeckDetailController>(() => DeckDetailController());
  }
}
