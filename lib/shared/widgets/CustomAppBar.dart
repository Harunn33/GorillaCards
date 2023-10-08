// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:gorillacards/routes/app_pages.dart';
import 'package:sizer/sizer.dart';

import '../constants/paddings.dart';
import '../enums/images.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool hasChevronLeftIcon;
  final void Function()? backFunc;
  const CustomAppBar({
    super.key,
    this.hasChevronLeftIcon = true,
    this.backFunc,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: double.infinity,
      leading: hasChevronLeftIcon
          ? Container(
              padding: AppPaddings.generalPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Bounceable(
                    onTap: backFunc ??
                        () {
                          Get.closeAllSnackbars();
                          Get.back();
                        },
                    child: Icon(
                      Icons.chevron_left_outlined,
                      size: 20.sp,
                    ),
                  ),
                  Expanded(child: Images.appLogo.png),
                  Bounceable(
                    onTap: () => Get.toNamed(Routes.SETTINGS),
                    child: Images.settings.svg,
                  ),
                ],
              ),
            )
          : Padding(
              padding: AppPaddings.generalPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Images.appLogo.png,
                  Bounceable(
                    onTap: () => Get.toNamed(Routes.SETTINGS),
                    child: Images.settings.svg,
                  )
                ],
              ),
            ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(6.h);
}
