// ignore_for_file: file_names

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:gorillacards/controllers/NetworkController.dart';
import 'package:gorillacards/modules/DeckDetail/DeckDetailController.dart';
import 'package:gorillacards/modules/Home/HomeController.dart';
import 'package:gorillacards/modules/Home/widgets/CustomFAB.dart';
import 'package:gorillacards/shared/constants/colors.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import 'package:gorillacards/shared/constants/spacer.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/widgets/CustomAppBar.dart';
import 'package:gorillacards/shared/widgets/CustomButton.dart';
import 'package:gorillacards/shared/widgets/CustomFlashCard.dart';
import 'package:gorillacards/shared/widgets/CustomInputLabel.dart';
import 'package:gorillacards/shared/widgets/CustomNoInternet.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class DeckDetail extends GetView<DeckDetailController> {
  const DeckDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    final NetworkController networkController = Get.put(NetworkController());
    return GetBuilder<NetworkController>(builder: (builder) {
      if (networkController.connectionType.value == 0) {
        return const CustomNoInternet();
      }
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBar(),
        body: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              controller.isLoading.value
                  ? Expanded(
                      child: Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: AppColors.primary,
                          size: 25.sp,
                        ),
                      ),
                    )
                  : controller.flashCards.isEmpty
                      ? Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              AppStrings.noCardsYet.tr,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.flashCards.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 70.w,
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(horizontal: 3.w),
                                child: FlipCard(
                                  controller: controller.flipCardController,
                                  front: _CustomCardSide(
                                    controller: controller,
                                    index: index,
                                    homeController: homeController,
                                    isFront: true,
                                  ),
                                  back: _CustomCardSide(
                                    controller: controller,
                                    homeController: homeController,
                                    index: index,
                                    isFront: false,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
              Obx(
                () => Container(
                  constraints: BoxConstraints(maxHeight: 20.h),
                  padding: AppPaddings.generalPadding,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomInputLabel(
                          label:
                              "${AppStrings.deckName.tr}: ${homeController.searchResults[controller.deckIndex].name}",
                        ),
                        AppSpacer.h1,
                        CustomInputLabel(
                          label:
                              "${AppStrings.cardCount.tr}: ${controller.flashCards.length}",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              AppSpacer.h3,
              Padding(
                padding: AppPaddings.generalPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomButton(
                      hasIcon: true,
                      icon: Icons.work_outline_outlined,
                      onTap: () => controller.redirectToFlashCardPage(context),
                      text: AppStrings.study.tr,
                      bg: AppColors.primary,
                      textColor: AppColors.white,
                      isWide: true,
                    ),
                    // AppSpacer.h1,
                    // CustomButton(
                    //   hasIcon: true,
                    //   icon: Icons.share_outlined,
                    //   onTap: () async {
                    //     print(controller
                    //         .homeController.allDecks[controller.deckIndex]
                    //         .toJson());
                    //     final lastId = await supabase
                    //         .from("decks")
                    //         .select("id")
                    //         .order("id", ascending: false)
                    //         .limit(1);

                    //     final Deck newDeck = Deck(
                    //       id: lastId[0]["id"] + 1,
                    //       name: controller
                    //           .homeController.allDecks[controller.deckIndex].name,
                    //       desc: controller
                    //           .homeController.allDecks[controller.deckIndex].desc,
                    //       content: controller.homeController
                    //           .allDecks[controller.deckIndex].content,
                    //       uid: "dd751128-28f2-4b91-8618-e38f0938ac58",
                    //     );
                    //     await supabase.from("decks").insert(newDeck.toJson());
                    //   },
                    //   text: "Desteyi Paylaş",
                    //   bg: AppColors.approvalGreen,
                    //   textColor: AppColors.white,
                    //   isWide: true,
                    // ),
                    AppSpacer.h1,
                    CustomButton(
                      hasIcon: true,
                      icon: Icons.edit_outlined,
                      onTap: () => controller.editDeck(context),
                      text: AppStrings.editDeck.tr,
                      bg: AppColors.santasGrey,
                      textColor: AppColors.white,
                      isWide: true,
                    ),
                    AppSpacer.h1,
                    CustomButton(
                      hasIcon: true,
                      icon: Icons.delete_outline_outlined,
                      onTap: () {
                        Get.closeAllSnackbars();
                        Get.back();
                        homeController.deleteDeck(controller.deckIndex);
                      },
                      text: AppStrings.deleteDeck.tr,
                      bg: AppColors.red,
                      textColor: AppColors.white,
                      isWide: true,
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        floatingActionButton: CustomFAB(
          title: AppStrings.addCard.tr,
          bg: AppColors.approvalGreen,
          onTap: () => controller.addFlashCard(context),
        ),
      );
    });
  }
}

class _CustomCardSide extends StatelessWidget {
  const _CustomCardSide({
    required this.controller,
    required this.homeController,
    required this.index,
    required this.isFront,
  });

  final DeckDetailController controller;
  final HomeController homeController;
  final int index;
  final bool isFront;

  @override
  Widget build(BuildContext context) {
    return CustomFlashCard(
      height: 25.h,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            child: Column(
              children: [
                Bounceable(
                  onTap: () async {
                    controller.editFlashCard(
                      context,
                      index,
                    );
                  },
                  child: const Icon(
                    Icons.edit_outlined,
                  ),
                ),
                AppSpacer.h1,
                Obx(
                  () => Bounceable(
                    onTap: controller.isLoading.value
                        ? null
                        : () async {
                            controller.deleteCard(index, homeController.uid);
                          },
                    child: Icon(
                      Icons.delete_outline_outlined,
                      color: AppColors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
          isFront
              ? Container(
                  padding: EdgeInsets.only(right: 4.w),
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        AppSpacer.h2,
                        Text(
                          controller.flashCards[index].front,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        AppSpacer.h2,
                        Icon(
                          Icons.touch_app_outlined,
                          color: AppColors.santasGrey,
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(right: 4.w),
                  child: SingleChildScrollView(
                    child: Text(
                      controller.flashCards[index].back,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
