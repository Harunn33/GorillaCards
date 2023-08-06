import 'package:get/get.dart';
import 'package:gorillacards/modules/Home/HomeController.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
