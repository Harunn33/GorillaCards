// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:gorillacards/modules/Curriculum/CurruiculumController.dart';
import 'package:gorillacards/routes/app_pages.dart';
import 'package:gorillacards/shared/constants/borderRadius.dart';
import 'package:gorillacards/shared/constants/colors.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import 'package:gorillacards/shared/constants/spacer.dart';
import 'package:gorillacards/shared/widgets/CustomAppBar.dart';
import 'package:sizer/sizer.dart';

class Curriculum extends GetView<CurriculumController> {
  const Curriculum({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CurriculumController());
    return Scaffold(
      appBar: const CustomAppBar(
          // backFunc: () {
          //   controller.storage.remove("A1");
          //   controller.storage.remove("A2");
          //   controller.storage.remove("B1");
          // },
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Bounceable(
                    onTap: () {
                      Get.toNamed(Routes.CURRICULUMTESTPAGE, parameters: {
                        "level": controller.getQuestionLevel(details.stepIndex),
                      });
                    },
                    child: Container(
                      padding: AppPaddings.h3v1Padding,
                      decoration: BoxDecoration(
                        color: AppColors.santasGrey.withOpacity(.15),
                        borderRadius: AppBorderRadius.generalRadius,
                      ),
                      child: Text(
                        "Translate Exercise",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                  AppSpacer.h1,
                  Bounceable(
                    onTap: () {},
                    child: Container(
                      padding: AppPaddings.h3v1Padding,
                      decoration: BoxDecoration(
                        color: AppColors.santasGrey.withOpacity(.15),
                        borderRadius: AppBorderRadius.generalRadius,
                      ),
                      child: Text(
                        "Fill In The Blank Exercise",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          onStepCancel: () {
            controller.currentStep.value -= 1;
          },
          onStepContinue: () {
            controller.currentStep.value += 1;
          },
          steps: [
            _CustomStepWidget(
              "A1",
              controller.storage.read(controller.getQuestionLevel(0)) ?? false,
            ),
            _CustomStepWidget(
              "A2",
              controller.storage.read(controller.getQuestionLevel(0)) ?? false,
            ),
            _CustomStepWidget(
              "B1",
              controller.storage.read(controller.getQuestionLevel(1)) ?? false,
            ),
            _CustomStepWidget(
              "B2",
              controller.storage.read(controller.getQuestionLevel(2)) ?? false,
            ),
            _CustomStepWidget(
              "C1",
              controller.storage.read(controller.getQuestionLevel(3)) ?? false,
            ),
            _CustomStepWidget(
              "C2",
              controller.storage.read(controller.getQuestionLevel(4)) ?? false,
            ),
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
