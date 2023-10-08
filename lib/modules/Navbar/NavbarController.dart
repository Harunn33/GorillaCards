// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorillacards/modules/Curriculum/Curriculum.dart';
import 'package:gorillacards/modules/Home/Home.dart';

class NavbarController extends GetxController {
  List<Widget> pages = [
    const Home(),
    const Curriculum(),
  ];
  RxInt tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
    update();
  }
}
