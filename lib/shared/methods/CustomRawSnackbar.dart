// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:gorillacards/modules/CurriculumTestPage/CurriculumTestPageController.dart';
import 'package:gorillacards/shared/constants/colors.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/enums/question_type.dart';

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
            Get.close(1);
            if (curriculumTestPageController.parameters["question_type"] ==
                QuestionType.Translate.name) {
              curriculumTestPageController.storage.write(
                  "${curriculumTestPageController.parameters["level"]}-${curriculumTestPageController.parameters["question_type"]}",
                  (curriculumTestPageController.correctCount.value /
                          curriculumTestPageController
                              .translateQuestionList.length) *
                      100);
            } else if (curriculumTestPageController
                    .parameters["question_type"] ==
                QuestionType.True_False.name) {
              curriculumTestPageController.storage.write(
                  "${curriculumTestPageController.parameters["level"]}-${curriculumTestPageController.parameters["question_type"]}",
                  (curriculumTestPageController.correctCount.value /
                          curriculumTestPageController
                              .trueFalseQuestionList.length) *
                      100);
            }
          } else {
            curriculumTestPageController.swiperController.next();
            curriculumTestPageController.selectedChoice.value = "";
            curriculumTestPageController.curriculumController.translatePercent
                .value = (curriculumTestPageController.correctCount.value /
                    curriculumTestPageController.translateQuestionList.length) *
                100;
            curriculumTestPageController.curriculumController.trueFalsePercent
                .value = (curriculumTestPageController.correctCount.value /
                    curriculumTestPageController.trueFalseQuestionList.length) *
                100;
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
