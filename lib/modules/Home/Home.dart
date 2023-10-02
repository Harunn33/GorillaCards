// ignore_for_file: file_names, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorillacards/modules/Home/HomeController.dart';
import 'package:gorillacards/modules/Home/widgets/CustomDeckCardItem.dart';
import 'package:gorillacards/modules/Home/widgets/CustomFAB.dart';
import 'package:gorillacards/modules/Home/widgets/SearchInput.dart';
import 'package:gorillacards/shared/constants/colors.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import 'package:gorillacards/shared/constants/spacer.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';
import '../../shared/widgets/CustomAppBar.dart';

class Home extends GetView<HomeController> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(
        hasChevronLeftIcon: false,
      ),
      body: Padding(
        padding: AppPaddings.generalPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppSpacer.h2,
            SearchInput(controller: controller),
            Expanded(
              child: FutureBuilder<void>(
                future: controller.getAllDecks(),
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
                      () => controller.allDecks.isEmpty
                          ? Container(
                              alignment: Alignment.center,
                              child: Text(
                                AppStrings.noDecksYet.tr,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            )
                          : RefreshIndicator(
                              color: AppColors.primary,
                              onRefresh: () async => controller.getAllDecks(),
                              child: ListView.builder(
                                itemCount: controller.searchResults.length,
                                padding: EdgeInsets.symmetric(vertical: 2.h),
                                itemBuilder: (context, index) {
                                  return CustomDeckCardItem(
                                    index: index,
                                    controller: controller,
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
      floatingActionButton: CustomFAB(
        title: AppStrings.addDeck.tr,
        onTap: () async {
          controller.createBottomSheet(context: context);
        },
      ),
    );
  }
}
