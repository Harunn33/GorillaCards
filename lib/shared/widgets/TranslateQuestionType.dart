import 'package:card_swiper/card_swiper.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorillacards/modules/CurriculumTestPage/CurriculumTestPageController.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import 'package:gorillacards/shared/constants/spacer.dart';
import 'package:gorillacards/shared/widgets/CustomChoice.dart';
import 'package:gorillacards/shared/widgets/CustomFlashCard.dart';
import 'package:sizer/sizer.dart';

class TranslateQuestionType extends StatelessWidget {
  final CurriculumTestPageController controller;
  const TranslateQuestionType({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Swiper(
          itemCount: controller.translateQuestionList.length,
          loop: false,
          controller: controller.swiperController,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              children: [
                FlipCard(
                  flipOnTouch: false,
                  controller: controller.flipCardController,
                  front: CustomFlashCard(
                    child: Container(
                      alignment: Alignment.center,
                      height: 20.h,
                      child: SingleChildScrollView(
                        child: Text(
                          controller.translateQuestionList[index].question,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                    ),
                  ),
                  back: CustomFlashCard(
                    child: Container(
                      alignment: Alignment.center,
                      height: 20.h,
                      child: SingleChildScrollView(
                        child: Text(
                          controller.translateQuestionList[index].answer,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                    ),
                  ),
                ),
                AppSpacer.h3,
                Padding(
                  padding: AppPaddings.generalPadding,
                  child: Obx(
                    () => Column(
                      children: [
                        CustomChoice(
                          title: controller
                              .translateQuestionList[index].options.a
                              .toString(),
                          curriculumTestPageController: controller,
                          isSelected: (controller.selectedChoice.value ==
                                  controller
                                      .translateQuestionList[index].options.a
                                      .toString())
                              .obs,
                          index: index,
                        ),
                        AppSpacer.w3,
                        CustomChoice(
                          title: controller
                              .translateQuestionList[index].options.b
                              .toString(),
                          curriculumTestPageController: controller,
                          isSelected: (controller.selectedChoice.value ==
                                  controller
                                      .translateQuestionList[index].options.b
                                      .toString())
                              .obs,
                          index: index,
                        ),
                        AppSpacer.w3,
                        CustomChoice(
                          title: controller
                              .translateQuestionList[index].options.c
                              .toString(),
                          curriculumTestPageController: controller,
                          isSelected: (controller.selectedChoice.value ==
                                  controller
                                      .translateQuestionList[index].options.c
                                      .toString())
                              .obs,
                          index: index,
                        ),
                        AppSpacer.w3,
                        CustomChoice(
                          title: controller
                              .translateQuestionList[index].options.d
                              .toString(),
                          curriculumTestPageController: controller,
                          isSelected: (controller.selectedChoice.value ==
                                  controller
                                      .translateQuestionList[index].options.d
                                      .toString())
                              .obs,
                          index: index,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }
}
