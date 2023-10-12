import 'package:card_swiper/card_swiper.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorillacards/modules/CurriculumTestPage/CurriculumTestPageController.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import 'package:gorillacards/shared/constants/spacer.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/enums/question_type.dart';
import 'package:gorillacards/shared/widgets/CustomChoice.dart';
import 'package:gorillacards/shared/widgets/CustomFlashCard.dart';
import 'package:sizer/sizer.dart';

class TrueFalseQuestionType extends StatelessWidget {
  const TrueFalseQuestionType({
    super.key,
    required this.controller,
  });

  final CurriculumTestPageController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Swiper(
        itemCount: controller.trueFalseQuestionList.length,
        loop: false,
        controller: controller.swiperController,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                children: [
                  // QUESTION
                  Expanded(
                    child: CustomFlashCard(
                      child: Container(
                        alignment: Alignment.center,
                        height: 10.h,
                        child: SingleChildScrollView(
                          child: Text(
                            controller.trueFalseQuestionList[index].question,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Text("="),
                  // ANSWER
                  Expanded(
                    child: FlipCard(
                      flipOnTouch: false,
                      controller: controller.flipCardController,
                      front: CustomFlashCard(
                        child: Container(
                          alignment: Alignment.center,
                          height: 10.h,
                          child: SingleChildScrollView(
                            child: Text(
                              controller.trueFalseQuestionList[index].answer,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ),
                      ),
                      back: CustomFlashCard(
                        child: Container(
                          alignment: Alignment.center,
                          height: 10.h,
                          child: SingleChildScrollView(
                            child: Text(
                              controller
                                  .trueFalseQuestionList[index].equivalent,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              AppSpacer.h3,
              Padding(
                padding: AppPaddings.generalPadding,
                child: Obx(
                  () => Column(
                    children: [
                      CustomChoice(
                        title: AppStrings.trueAnswer.tr,
                        curriculumTestPageController: controller,
                        isSelected: (controller.selectedChoice.value ==
                                AppStrings.trueAnswer.tr)
                            .obs,
                        index: index,
                        questionType: QuestionType.True_False,
                      ),
                      CustomChoice(
                        title: AppStrings.falseAnswer.tr,
                        curriculumTestPageController: controller,
                        isSelected: (controller.selectedChoice.value ==
                                AppStrings.falseAnswer.tr)
                            .obs,
                        index: index,
                        questionType: QuestionType.True_False,
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
