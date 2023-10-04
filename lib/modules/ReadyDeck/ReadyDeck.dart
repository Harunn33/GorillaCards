// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:gorillacards/modules/Home/widgets/SearchInput.dart';
import 'package:gorillacards/modules/ReadyDeck/ReadyDeckController.dart';
import 'package:gorillacards/routes/app_pages.dart';
import 'package:gorillacards/shared/constants/colors.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import 'package:gorillacards/shared/constants/spacer.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/widgets/CustomAppBar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class ReadyDeck extends GetView<ReadyDeckController> {
  const ReadyDeck({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ReadyDeckController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: AppPaddings.generalPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppSpacer.h2,
            SearchInput(
              controller: controller,
            ),
            Expanded(
              child: FutureBuilder<void>(
                future: controller.getReadyDeck(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: AppColors.primary,
                        size: 25.sp,
                      ),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return Obx(
                      () => controller.readyDeckList.isEmpty
                          ? Container(
                              alignment: Alignment.center,
                              child: Text(
                                AppStrings.noDecksYet.tr,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            )
                          : RefreshIndicator(
                              color: AppColors.primary,
                              onRefresh: () async => controller.getReadyDeck(),
                              child: ListView.builder(
                                itemCount: controller.searchResults.length,
                                padding: EdgeInsets.symmetric(vertical: 2.h),
                                itemBuilder: (context, index) {
                                  final Color color =
                                      controller.getReadyDeckBgColor(
                                          controller.searchResults[index].name);
                                  return Bounceable(
                                    onTap: () {
                                      Get.toNamed(
                                        Routes.READYDECKVIEWER,
                                        arguments: [
                                          controller
                                              .searchResults[index].content,
                                          color
                                        ],
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                        vertical: .5.h,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                            width: .6.w,
                                            color: color,
                                          ),
                                        ),
                                        color: AppColors.santasGrey
                                            .withOpacity(.15),
                                      ),
                                      padding: AppPaddings.h3v1Padding,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller
                                                .searchResults[index].name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                          AppSpacer.h1,
                                          Text(
                                            controller
                                                .searchResults[index].desc,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                    );
                  }
                  return const Text("404 Not Found");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
