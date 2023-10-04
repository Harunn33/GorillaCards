// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorillacards/modules/ReadyDeckViewer/ReadyDeckViewerController.dart';
import 'package:gorillacards/shared/constants/borderRadius.dart';
import 'package:gorillacards/shared/constants/colors.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import 'package:gorillacards/shared/constants/spacer.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/widgets/CustomButton.dart';
import 'package:sizer/sizer.dart';

Future<dynamic> CustomPageViewModalSheet(
    BuildContext context,
    ReadyDeckViewerController readyDeckViewerController,
    PageController pageController) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        width: 100.w,
        padding: AppPaddings.h3v1Padding,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: AppBorderRadius.generalRadius,
        ),
        child: Column(
          children: [
            const Spacer(),
            Expanded(
              child: PageView.builder(
                onPageChanged: (value) {
                  readyDeckViewerController.pageIndex.value = value;
                },
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                itemCount: readyDeckViewerController.flashCards.length,
                itemBuilder: (context, pageIndex) {
                  return Text(
                    readyDeckViewerController.flashCards[pageIndex].back,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  );
                },
              ),
            ),
            const Spacer(),
            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onTap: readyDeckViewerController.pageIndex.value == 0
                          ? null
                          : () {
                              pageController.previousPage(
                                duration: const Duration(
                                  milliseconds: 500,
                                ),
                                curve: Curves.easeOut,
                              );
                            },
                      isWide: true,
                      text: AppStrings.back.tr,
                      bg: readyDeckViewerController.args[1],
                      textColor: AppColors.white,
                    ),
                  ),
                  AppSpacer.w1,
                  Expanded(
                    child: CustomButton(
                      onTap: readyDeckViewerController.pageIndex.value ==
                              readyDeckViewerController.flashCards.length - 1
                          ? null
                          : () {
                              pageController.nextPage(
                                duration: const Duration(
                                  milliseconds: 500,
                                ),
                                curve: Curves.easeIn,
                              );
                            },
                      isWide: true,
                      text: AppStrings.next.tr,
                      bg: readyDeckViewerController.args[1],
                      textColor: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      );
    },
  );
}
