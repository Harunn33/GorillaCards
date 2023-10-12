// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:gorillacards/modules/CurriculumTestPage/CurriculumTestPageController.dart';
import 'package:gorillacards/shared/constants/borderRadius.dart';
import 'package:gorillacards/shared/constants/colors.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import 'package:gorillacards/shared/enums/question_type.dart';
import 'package:sizer/sizer.dart';

class CustomChoice extends StatelessWidget {
  final String title;
  final CurriculumTestPageController curriculumTestPageController;
  RxBool isSelected;
  final int index;
  final QuestionType? questionType;
  CustomChoice({
    super.key,
    required this.title,
    required this.curriculumTestPageController,
    required this.isSelected,
    required this.index,
    this.questionType = QuestionType.Translate,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: curriculumTestPageController.selectedChoice.value.isNotEmpty
          ? null
          : () {
              if (questionType == QuestionType.Translate) {
                curriculumTestPageController.handleAnswerControl(context,
                    index: index,
                    title: title,
                    equalText: curriculumTestPageController
                        .translateQuestionList[index].answer,
                    questionType: QuestionType.Translate);
              } else if (questionType == QuestionType.True_False) {
                curriculumTestPageController.handleAnswerControl(
                  context,
                  index: index,
                  title: title,
                  equalText: curriculumTestPageController
                      .checkAnswerForBoolType(curriculumTestPageController
                          .trueFalseQuestionList[index].answerBoolType),
                  questionType: QuestionType.True_False,
                );
              }
            },
      child: Container(
        width: 100.w,
        margin: EdgeInsets.only(bottom: 2.h),
        padding: AppPaddings.h3v1Padding,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              spreadRadius: 3,
              offset: const Offset(
                0,
                1.5,
              ),
              color: isSelected.value
                  ? AppColors.brilliantAzure
                  : AppColors.black.withOpacity(.1),
            )
          ],
          borderRadius: AppBorderRadius.generalRadius,
          color: isSelected.value ? AppColors.frozenLandscape : AppColors.white,
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: isSelected.value ? AppColors.usafaBlue : AppColors.black,
              ),
        ),
      ),
    );
  }
}
