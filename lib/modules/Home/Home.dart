import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:gorillacards/modules/Home/HomeController.dart';
import 'package:gorillacards/modules/Signin/SigninController.dart';

class Home extends GetView<HomeController> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(),
      body: Bounceable(
        onTap: () => {SigninController().box.remove("token")},
        child: Container(
          alignment: Alignment.center,
          child: const Text("Home"),
        ),
      ),
    );
  }
}
