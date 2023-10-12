// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:gorillacards/modules/CurriculumTestPage/CurriculumTestPageController.dart';
import 'package:gorillacards/shared/constants/colors.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import 'package:gorillacards/shared/constants/strings.dart';

SnackbarController CustomRawSnackbar(
    {required BuildContext context,
    required CurriculumTestPageController curriculumTestPageController,
    required int questionListLength,
    required int index,
    required String title,
    required String message,
    Color? bg}) {
  return Get.rawSnackbar(
    isDismissible: false,
    backgroundColor: bg ?? AppColors.red,
    duration: const Duration(days: 365),
    title: title,
    message: message,
    mainButton: Padding(
      padding: AppPaddings.generalPadding,
      child: Bounceable(
        onTap: () {
          if (index == questionListLength) {
            Get.closeAllSnackbars();
            curriculumTestPageController.storage.write(
                curriculumTestPageController.parameters["level"].toString(),
                true);
            curriculumTestPageController
                .curriculumController.currentStep.value += 1;
            Get.close(1);
          } else {
            curriculumTestPageController.swiperController.next();
            curriculumTestPageController.selectedChoice.value = "";
            Get.back();
          }
        },
        child: Text(
          AppStrings.continueText.tr,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.white,
              ),
        ),
      ),
    ),
  );
}
