import 'package:get/get.dart';
import 'package:gorillacards/modules/Result/ResultController.dart';

class ResultBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResultController>(() => ResultController());
  }
}
