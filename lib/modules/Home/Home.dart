// ignore_for_file: file_names, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:gorillacards/controllers/NetworkController.dart';
import 'package:gorillacards/modules/Home/HomeController.dart';
import 'package:gorillacards/modules/Home/widgets/CustomDeckCardItem.dart';
import 'package:gorillacards/modules/Home/widgets/CustomFAB.dart';
import 'package:gorillacards/modules/Home/widgets/SearchInput.dart';
import 'package:gorillacards/routes/app_pages.dart';
import 'package:gorillacards/shared/constants/colors.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import 'package:gorillacards/shared/constants/spacer.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/enums/images.dart';
import 'package:gorillacards/shared/widgets/CustomNoInternet.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class Home extends GetView<HomeController> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    final NetworkController networkController = Get.put(NetworkController());
    return GetBuilder<NetworkController>(builder: (builder) {
      if (networkController.connectionType.value == 0) {
        return const CustomNoInternet();
      }
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: AppPaddings.generalPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppSpacer.h2,
              Row(
                children: [
                  Expanded(
                    child: SearchInput(
                      controller: controller,
                    ),
                  ),
                  AppSpacer.w2,
                  Bounceable(
                    onTap: () {
                      Get.toNamed(Routes.READYDECK);
                    },
                    child: SizedBox(
                      width: 5.h,
                      height: 5.h,
                      child: Images.readyDecks.png,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Obx(
                  () => controller.isLoading.value
                      ? Center(
                          child: LoadingAnimationWidget.staggeredDotsWave(
                            color: AppColors.primary,
                            size: 25.sp,
                          ),
                        )
                      : controller.allDecks.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 15.h,
                                  child: Images.emptyDeck.png,
                                ),
                                AppSpacer.h1,
                                Text(
                                  AppStrings.noDecksYet.tr,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
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
    });
  }
}
