// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:gorillacards/modules/ReadyDeckViewer/ReadyDeckViewerController.dart';
import 'package:gorillacards/shared/constants/borderRadius.dart';
import 'package:gorillacards/shared/constants/colors.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import 'package:gorillacards/shared/constants/spacer.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/widgets/CustomAppBar.dart';
import 'package:gorillacards/shared/widgets/CustomInputLabel.dart';
import 'package:sizer/sizer.dart';

class ReadyDeckViewer extends GetView<ReadyDeckViewerController> {
  const ReadyDeckViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: AppPaddings.generalPadding.copyWith(
          top: 2.h,
          bottom: 2.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomInputLabel(
              label: AppStrings.label.tr,
            ),
            AppSpacer.h1,
            Expanded(
              child: MasonryGridView.builder(
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                mainAxisSpacing: 2.h,
                crossAxisSpacing: 4.w,
                itemCount: 16,
                itemBuilder: (context, index) {
                  return Container(
                    alignment: Alignment.center,
                    padding: AppPaddings.h3v1Padding,
                    decoration: BoxDecoration(
                      borderRadius: AppBorderRadius.generalRadius,
                      color: controller.args[1],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${controller.args[0][index].front}",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: AppColors.white,
                              ),
                        ),
                        AppSpacer.h2,
                        Text(
                          AppStrings.deckDetailFlashCardFrontInfo.tr,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: AppColors.white,
                                  ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
