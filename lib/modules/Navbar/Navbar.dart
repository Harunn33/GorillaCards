// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorillacards/modules/Navbar/NavbarController.dart';
import 'package:gorillacards/shared/constants/borderRadius.dart';
import 'package:gorillacards/shared/constants/colors.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import 'package:gorillacards/shared/enums/images.dart';
import 'package:gorillacards/shared/widgets/CustomAppBar.dart';
import 'package:sizer/sizer.dart';

class Navbar extends GetView<NavbarController> {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NavbarController());
    return GetBuilder<NavbarController>(
      builder: (context) {
        return Scaffold(
          appBar: const CustomAppBar(
            hasChevronLeftIcon: false,
          ),
          body: IndexedStack(
            index: controller.tabIndex.value,
            children: controller.pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: AppColors.white,
            currentIndex: controller.tabIndex.value,
            onTap: controller.changeTabIndex,
            items: [
              _bottomNavBarItem(
                Images.home.png,
                controller.tabIndex.value == 0,
              ),
              _bottomNavBarItem(
                Images.curriculum.png,
                controller.tabIndex.value == 1,
              ),
            ],
          ),
        );
      },
    );
  }

  _bottomNavBarItem(Widget child, bool isSelected) {
    return BottomNavigationBarItem(
      icon: Container(
        height: 4.5.h,
        padding: AppPaddings.h3v1Padding,
        decoration: isSelected
            ? BoxDecoration(
                borderRadius: AppBorderRadius.generalRadius,
                border: Border.all(
                  width: .3.w,
                  color: AppColors.primary,
                ),
              )
            : null,
        child: child,
      ),
      label: "",
    );
  }
}
