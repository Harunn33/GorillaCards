// ignore_for_file: file_names

import 'package:card_swiper/card_swiper.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorillacards/controllers/NetworkController.dart';
import 'package:gorillacards/modules/FlashCardPage/FlashCardPageController.dart';
import 'package:gorillacards/shared/constants/colors.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import 'package:gorillacards/shared/constants/spacer.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/enums/images.dart';
import 'package:gorillacards/shared/widgets/CustomAppBar.dart';
import 'package:gorillacards/shared/widgets/CustomButton.dart';
import 'package:gorillacards/shared/widgets/CustomFlashCard.dart';
import 'package:gorillacards/shared/widgets/CustomModalBottomSheetTextFormField.dart';
import 'package:gorillacards/shared/widgets/CustomNoInternet.dart';
import 'package:sizer/sizer.dart';

class FlashCardPage extends GetView<FlashCardPageController> {
  const FlashCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NetworkController>(builder: (networkController) {
      if (networkController.connectionType.value == 0) {
        return const CustomNoInternet();
      }
      return Scaffold(
        appBar: const CustomAppBar(),
        resizeToAvoidBottomInset: false,
        body: Container(
          height: 100.h,
          width: 100.w,
          padding: AppPaddings.generalPadding,
          child: Form(
            key: controller.formKey,
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSpacer.h2,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _CustomIconAndTextRow(
                          icon: Images.correct,
                          title: controller.correctAnswers.value.toString()),
                      _CustomIconAndTextRow(
                          icon: Images.question_mark,
                          title: controller.emptyAnswers.value.toString()),
                      _CustomIconAndTextRow(
                          icon: Images.wrong,
                          title: controller.wrongAnswers.value.toString()),
                    ],
                  ),
                  AppSpacer.h1,
                  SizedBox(
                    height: 25.h,
                    child: Swiper(
                      itemCount: controller.flashCards.length,
                      layout: SwiperLayout.DEFAULT,
                      loop: false,
                      controller: controller.swiperController,
                      physics: const NeverScrollableScrollPhysics(),
                      onIndexChanged: (value) {
                        controller.index.value = value;
                        controller.answerController.clear();
                      },
                      itemBuilder: (context, index) {
                        return FlipCard(
                          flipOnTouch: false,
                          controller: controller.flipCardController,
                          front: CustomFlashCard(
                            height: 25.h,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                controller.flashCards[index].front,
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                            ),
                          ),
                          back: CustomFlashCard(
                            height: 25.h,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                controller.flashCards[index].back,
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  AppSpacer.h2,
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.question.tr,
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: AppColors.black,
                                  ),
                        ),
                        AppSpacer.h3,
                        CustomModalBottomSheetTextFormField(
                          hintText: AppStrings.inputHintText.tr,
                          focusNode: controller.answerFocusNode,
                          controller: controller.answerController,
                          onTapOutside: (p0) =>
                              controller.answerFocusNode.unfocus(),
                          submit: (p0) {
                            controller.checkAnswer(controller.flashCards);
                            return null;
                          },
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                onTap: () {
                                  controller.flipCardController.state
                                      ?.toggleCard();
                                },
                                text: AppStrings.rotate.tr,
                                bg: AppColors.approvalGreen,
                                isWide: true,
                                textColor: AppColors.white,
                              ),
                            ),
                            AppSpacer.w1,
                            Expanded(
                              child: CustomButton(
                                onTap: () => controller
                                    .checkAnswer(controller.flashCards),
                                text: controller.index.value ==
                                        controller.flashCards.length - 1
                                    ? AppStrings.done.tr
                                    : AppStrings.next.tr,
                                bg: AppColors.primary,
                                textColor: AppColors.white,
                                isWide: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class _CustomIconAndTextRow extends StatelessWidget {
  const _CustomIconAndTextRow({
    required this.icon,
    required this.title,
  });

  final Images icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 2.5.h,
          height: 2.5.h,
          child: icon.png,
        ),
        AppSpacer.w1,
        Text(
          title,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.black,
              ),
        ),
      ],
    );
  }
}
