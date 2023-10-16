// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:gorillacards/modules/Curriculum/CurruiculumController.dart';
import 'package:gorillacards/routes/app_pages.dart';
import 'package:gorillacards/shared/constants/borderRadius.dart';
import 'package:gorillacards/shared/constants/colors.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import 'package:gorillacards/shared/constants/spacer.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/enums/question_type.dart';
import 'package:gorillacards/shared/widgets/CustomAppBar.dart';
import 'package:sizer/sizer.dart';

class Curriculum extends GetView<CurriculumController> {
  const Curriculum({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CurriculumController());
    controller.getCurrentStep();
    return Scaffold(
      appBar: CustomAppBar(
        backFunc: () {
          controller.storage.remove("A1-Translate");
          controller.storage.remove("A1-True_False");
          controller.storage.remove("A2");
          controller.storage.remove("B1");
        },
      ),
      body: Obx(
        () => Stepper(
          currentStep: controller.currentStep.value,
          physics: const ClampingScrollPhysics(),
          onStepTapped: (value) {
            if (controller.storage
                    .read(controller.getQuestionLevel(value - 1)) ??
                false ||
                    controller.storage
                        .read(controller.getQuestionLevel(value))) {
              controller.currentStep.value = value;
            }
          },
          controlsBuilder: (context, details) {
            return SizedBox(
              width: 100.w,
              child: Obx(() {
                RxDouble value1 = 0.0.obs;
                RxDouble value2 = 0.0.obs;
                value1.value = controller.storage.read(
                        "${controller.getQuestionLevel(details.stepIndex)}-${QuestionType.Translate.name}") ??
                    0.0;
                value2.value = controller.storage.read(
                        "${controller.getQuestionLevel(details.stepIndex)}-${QuestionType.True_False.name}") ??
                    0.0;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CustomExerciseButton(
                        title: AppStrings.translateExerciseTitle.tr,
                        onTap: () => Get.toNamed(
                              Routes.CURRICULUMTESTPAGE,
                              parameters: {
                                "level": controller
                                    .getQuestionLevel(details.stepIndex),
                                "question_type": QuestionType.Translate.name
                              },
                            ),
                        percent: value1.value),
                    AppSpacer.h1,
                    _CustomExerciseButton(
                      title: AppStrings.trueFalseExerciseTitle.tr,
                      onTap: () => Get.toNamed(
                        Routes.CURRICULUMTESTPAGE,
                        parameters: {
                          "level":
                              controller.getQuestionLevel(details.stepIndex),
                          "question_type": QuestionType.True_False.name
                        },
                      ),
                      percent: value2.value,
                    ),
                    // AppSpacer.h1,
                    // controller.hasNext.value
                    //     ? Bounceable(
                    //         onTap: () {
                    //           controller.currentStep.value += 1;
                    //         },
                    //         child: const Text(
                    //           "Sonraki adıma geçebilirsin",
                    //         ),
                    //       )
                    //     : const Text(
                    //         "Sonraki adıma geçemezsin",
                    //       ),
                  ],
                );
              }),
            );
          },
          onStepCancel: () {},
          onStepContinue: () {},
          steps: [
            _CustomStepWidget("A1", controller.stepActiveStateList[0]),
            _CustomStepWidget("A2", controller.stepActiveStateList[1]),
            _CustomStepWidget("B1", controller.stepActiveStateList[2]),
            _CustomStepWidget("B2", controller.stepActiveStateList[3]),
            _CustomStepWidget("C1", controller.stepActiveStateList[4]),
            _CustomStepWidget("C2", controller.stepActiveStateList[5]),
          ],
        ),
      ),
    );
  }

  Step _CustomStepWidget(String level, bool isCompleted) {
    return Step(
      title: Text(level),
      content: const SizedBox(),
      state:
          isCompleted || level == "A1" ? StepState.indexed : StepState.disabled,
      isActive: isCompleted || level == "A1",
    );
  }
}

class _CustomExerciseButton extends StatelessWidget {
  const _CustomExerciseButton({
    required this.title,
    required this.onTap,
    required this.percent,
  });

  final String title;
  final void Function() onTap;
  final double percent;

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Container(
        padding: AppPaddings.h3v1Padding,
        decoration: BoxDecoration(
          color: AppColors.santasGrey.withOpacity(.15),
          borderRadius: AppBorderRadius.generalRadius,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            AppSpacer.w1,
            Text(
              "%$percent",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
