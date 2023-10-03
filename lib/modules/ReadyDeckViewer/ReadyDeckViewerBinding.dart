// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:gorillacards/modules/ReadyDeckViewer/ReadyDeckViewerController.dart';

class ReadyDeckViewerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadyDeckViewerController>(() => ReadyDeckViewerController());
  }
}
