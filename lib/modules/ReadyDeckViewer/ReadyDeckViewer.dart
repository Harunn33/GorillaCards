// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:gorillacards/controllers/NetworkController.dart';
import 'package:gorillacards/modules/ReadyDeckViewer/ReadyDeckViewerController.dart';
import 'package:gorillacards/shared/constants/borderRadius.dart';
import 'package:gorillacards/shared/constants/colors.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import 'package:gorillacards/shared/constants/spacer.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/methods/CustomPageViewModalSheet.dart';
import 'package:gorillacards/shared/widgets/CustomAppBar.dart';
import 'package:gorillacards/shared/widgets/CustomInputLabel.dart';
import 'package:gorillacards/shared/widgets/CustomNoInternet.dart';
import 'package:sizer/sizer.dart';

class ReadyDeckViewer extends GetView<ReadyDeckViewerController> {
  const ReadyDeckViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NetworkController>(builder: (networkController) {
      if (networkController.connectionType.value == 0) {
        return const CustomNoInternet();
      }
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomInputLabel(
                      label:
                          "${AppStrings.total.tr}: ${controller.flashCards.length}"),
                  Bounceable(
                    onTap: () => controller.flashCards.shuffle(),
                    child: const Icon(
                      Icons.shuffle_outlined,
                    ),
                  ),
                ],
              ),
              AppSpacer.h1,
              Expanded(
                child: Obx(
                  () => ListView.separated(
                    separatorBuilder: (context, index) => AppSpacer.h2,
                    itemCount: controller.flashCards.length,
                    itemBuilder: (context, index) {
                      return _CustomCard(
                        controller: controller,
                        title: controller.flashCards[index].front,
                        onTap: () {
                          final PageController pageController =
                              PageController(initialPage: index);
                          controller.pageIndex.value = index;
                          CustomPageViewModalSheet(
                              context, controller, pageController);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _CustomCard extends StatelessWidget {
  const _CustomCard({
    required this.controller,
    required this.title,
    required this.onTap,
  });

  final ReadyDeckViewerController controller;
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: AppPaddings.h3v1Padding,
        decoration: BoxDecoration(
          borderRadius: AppBorderRadius.generalRadius,
          color: controller.args[1],
        ),
        child: Column(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.white,
                  ),
            ),
            AppSpacer.h2,
            Icon(
              Icons.touch_app_outlined,
              color: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
