// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorillacards/modules/Result/ResultController.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/enums/lottie.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';
import '../constants/fonts.dart';
import '../constants/paddings.dart';
import '../constants/spacer.dart';
import '../widgets/CustomFlashCard.dart';

Future<dynamic> CustomReportsModalBottomSheet(
    BuildContext context, ResultController resultController) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.white,
    builder: (context) {
      return Container(
        padding: EdgeInsets.only(
          top: 1.h,
          bottom: 2.h,
        ),
        child: Column(
          children: [
            Text(
              AppStrings.testReportsModalBottomSheetTitle.tr,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontFamily: AppFonts.semibold,
                  ),
            ),
            AppSpacer.h1,
            resultController.reports.isEmpty
                ? Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                              height: 30.h,
                              child: CustomLottie.congrats.lottieAsset),
                          Text(
                            AppStrings.congratulationsMessage.tr,
                          ),
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.separated(
                      padding: AppPaddings.h3v1Padding,
                      itemCount: resultController.reports.length,
                      separatorBuilder: (context, index) {
                        return AppSpacer.h1;
                      },
                      itemBuilder: (context, index) {
                        return FlipCard(
                          front: CustomFlashCard(
                            height: 25.h,
                            child: Align(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox.shrink(),
                                  Text(
                                    resultController.reports[index].front,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                  ),
                                  Icon(
                                    Icons.touch_app_outlined,
                                    color: AppColors.santasGrey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          back: CustomFlashCard(
                            height: 25.h,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                resultController.reports[index].back,
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      );
    },
  );
}
