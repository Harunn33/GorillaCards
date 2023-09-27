// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorillacards/modules/FlashCardPage/FlashCardPageController.dart';
import 'package:gorillacards/modules/Result/ResultController.dart';
import 'package:gorillacards/shared/constants/colors.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import 'package:gorillacards/shared/constants/spacer.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/enums/lottie.dart';
import 'package:gorillacards/shared/widgets/CustomAppBar.dart';
import 'package:gorillacards/shared/widgets/CustomInputLabel.dart';
import 'package:gorillacards/shared/widgets/CustomTextButton.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sizer/sizer.dart';

import '../../shared/methods/CustomReportsModalBottomSheet.dart';

class Result extends GetView<ResultController> {
  const Result({super.key});

  @override
  Widget build(BuildContext context) {
    final FlashCardPageController flashCardPageController = Get.find();
    Get.put(ResultController());
    return Scaffold(
      appBar: CustomAppBar(
        backFunc: () => Get.close(2),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Get.close(2);
          return true;
        },
        child: Padding(
          padding: AppPaddings.generalPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomLottie.cup.lottieAsset,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => SizedBox(
                        height: 17.5.h,
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.results.length,
                          itemBuilder: (context, index) {
                            return _CustomLinearPercentIndicator(
                                flashCardPageController:
                                    flashCardPageController,
                                value: controller.results[index]["value"],
                                color: controller.results[index]["color"],
                                title: controller.results[index]["title"]);
                          },
                          separatorBuilder: (context, index) => AppSpacer.h1,
                        ),
                      ),
                    ),
                    AppSpacer.h3,
                    CustomTextButton(
                      onTap: () =>
                          CustomReportsModalBottomSheet(context, controller),
                      title: AppStrings.showTestReportsBtnTitle,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomLinearPercentIndicator extends StatelessWidget {
  const _CustomLinearPercentIndicator({
    required this.flashCardPageController,
    required this.value,
    required this.color,
    required this.title,
  });

  final FlashCardPageController flashCardPageController;
  final double value;
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomInputLabel(label: "$title: ${value.toInt()}"),
        AppSpacer.h1,
        LinearPercentIndicator(
          animation: true,
          lineHeight: 1.5.h,
          padding: EdgeInsets.zero,
          percent: value / flashCardPageController.flashCards.length,
          backgroundColor: AppColors.dreamyCloud,
          progressColor: color,
          barRadius: Radius.circular(5.sp),
        ),
      ],
    );
  }
}
