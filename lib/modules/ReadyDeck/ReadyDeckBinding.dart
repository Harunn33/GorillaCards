// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:gorillacards/modules/ReadyDeck/ReadyDeckController.dart';

class ReadyDeckBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadyDeckController>(() => ReadyDeckController());
  }
}
