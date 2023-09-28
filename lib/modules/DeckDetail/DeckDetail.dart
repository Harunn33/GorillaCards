// ignore_for_file: file_names

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:gorillacards/modules/DeckDetail/DeckDetailController.dart';
import 'package:gorillacards/modules/Home/HomeController.dart';
import 'package:gorillacards/shared/constants/colors.dart';
import 'package:gorillacards/shared/constants/spacer.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/widgets/CustomAppBar.dart';
import 'package:gorillacards/shared/widgets/CustomFlashCard.dart';
import 'package:sizer/sizer.dart';

class DeckDetail extends GetView<DeckDetailController> {
  const DeckDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final HomeController homeController = Get.find();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(),
      body: Obx(
        () => Column(
          children: [
            AppSpacer.h1,
            controller.flashCards.isEmpty
                ? Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        AppStrings.noCardsYet,
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
                          margin: EdgeInsets.symmetric(horizontal: 3.w),
                          child: FlipCard(
                            controller: controller.flipCardController,
                            front: CustomFlashCard(
                              height: 25.h,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox.shrink(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        controller.flashCards[index].front,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge,
                                      ),
                                      Text(
                                        AppStrings.deckDetailFlashCardFrontInfo,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Bounceable(
                                        onTap: () async {
                                          controller.editFlashCard(
                                              context, index, args[1]);
                                        },
                                        child: const Icon(
                                          Icons.edit_outlined,
                                        ),
                                      ),
                                      AppSpacer.h1,
                                      Bounceable(
                                        onTap: () async {
                                          controller.deleteCard(index, args[1],
                                              homeController.uid);
                                        },
                                        child: Icon(
                                          Icons.delete_outline_outlined,
                                          color: AppColors.red,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            back: CustomFlashCard(
                              height: 25.h,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox.shrink(),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      controller.flashCards[index].back,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge,
                                    ),
                                  ),
                                  Bounceable(
                                    onTap: () {
                                      print(controller.flashCards[index].back);
                                    },
                                    child: const Icon(
                                      Icons.edit_outlined,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
