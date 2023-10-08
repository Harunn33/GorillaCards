// ignore_for_file: file_names, must_be_immutable, non_constant_identifier_names

import 'package:card_swiper/card_swiper.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:gorillacards/modules/CurriculumTestPage/CurriculumTestPageController.dart';
import 'package:gorillacards/shared/constants/borderRadius.dart';
import 'package:gorillacards/shared/constants/colors.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import 'package:gorillacards/shared/constants/spacer.dart';
import 'package:gorillacards/shared/widgets/CustomAppBar.dart';
import 'package:gorillacards/shared/widgets/CustomFlashCard.dart';
import 'package:sizer/sizer.dart';

class CurriculumTestPage extends GetView<CurriculumTestPageController> {
  const CurriculumTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: AppPaddings.generalPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppSpacer.h3,
            Expanded(
              child: Obx(
                () => Swiper(
                  itemCount: controller.questionList.length,
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
                                  controller.questionList[index].question,
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
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
                                  controller.questionList[index].answer,
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
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
                                _Choice(
                                  title: controller
                                      .questionList[index].options.a
                                      .toString(),
                                  curriculumTestPageController: controller,
                                  answer: controller.questionList[index].answer,
                                  isSelected:
                                      (controller.selectedChoice.value ==
                                              controller
                                                  .questionList[index].options.a
                                                  .toString())
                                          .obs,
                                  index: index,
                                ),
                                AppSpacer.w3,
                                _Choice(
                                  title: controller
                                      .questionList[index].options.b
                                      .toString(),
                                  answer: controller.questionList[index].answer,
                                  curriculumTestPageController: controller,
                                  isSelected:
                                      (controller.selectedChoice.value ==
                                              controller
                                                  .questionList[index].options.b
                                                  .toString())
                                          .obs,
                                  index: index,
                                ),
                                AppSpacer.w3,
                                _Choice(
                                  title: controller
                                      .questionList[index].options.c
                                      .toString(),
                                  answer: controller.questionList[index].answer,
                                  curriculumTestPageController: controller,
                                  isSelected:
                                      (controller.selectedChoice.value ==
                                              controller
                                                  .questionList[index].options.c
                                                  .toString())
                                          .obs,
                                  index: index,
                                ),
                                AppSpacer.w3,
                                _Choice(
                                  title: controller
                                      .questionList[index].options.d
                                      .toString(),
                                  answer: controller.questionList[index].answer,
                                  curriculumTestPageController: controller,
                                  isSelected:
                                      (controller.selectedChoice.value ==
                                              controller
                                                  .questionList[index].options.d
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
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Choice extends StatelessWidget {
  final String title;
  final CurriculumTestPageController curriculumTestPageController;
  RxBool isSelected;
  final String answer;
  final int index;
  _Choice({
    required this.title,
    required this.curriculumTestPageController,
    required this.isSelected,
    required this.answer,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: curriculumTestPageController.selectedChoice.value.isNotEmpty
          ? null
          : () {
              curriculumTestPageController.selectedChoice.value = title;
              if (curriculumTestPageController.selectedChoice.value
                      .toLowerCase()
                      .trim() ==
                  answer.toLowerCase().trim()) {
                CustomRawSnackbar(
                  context: context,
                  title: "Başarılı",
                  message: "Doğru Bildin",
                  bg: AppColors.dustyGreen,
                );
              } else {
                curriculumTestPageController.flipCardController.state
                    ?.toggleCard();
                CustomRawSnackbar(
                  context: context,
                  title: "Hatalı",
                  message: "Yanlış Bildin",
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

  SnackbarController CustomRawSnackbar(
      {required BuildContext context,
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
            if (index == curriculumTestPageController.questionList.length - 1) {
              print("Sınav bitti");
              curriculumTestPageController.storage.write(
                  curriculumTestPageController.parameters["level"].toString(),
                  true);
              curriculumTestPageController
                  .curriculumController.currentStep.value += 1;
              Get.closeAllSnackbars();
              Get.close(1);
            } else {
              Get.closeAllSnackbars();
              curriculumTestPageController.swiperController.next();
              curriculumTestPageController.selectedChoice.value = "";
            }
          },
          child: Text(
            "Devam et",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.white,
                ),
          ),
        ),
      ),
    );
  }
}
