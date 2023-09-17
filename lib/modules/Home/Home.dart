// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:gorillacards/modules/Home/HomeController.dart';
import 'package:gorillacards/shared/constants/borderRadius.dart';
import 'package:gorillacards/shared/constants/colors.dart';
import 'package:gorillacards/shared/constants/fonts.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import 'package:gorillacards/shared/constants/spacer.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:sizer/sizer.dart';

import '../../routes/app_pages.dart';
import '../../shared/widgets/CustomAppBar.dart';

class Home extends GetView<HomeController> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: AppPaddings.generalPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppSpacer.h2,
            _SearchInput(controller: controller),
            Expanded(
              child: FutureBuilder<void>(
                future: controller.getAllDecks(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done &&
                      controller.allDecks.isEmpty) {
                    return Container(
                      alignment: Alignment.center,
                      child: Text(
                        AppStrings.noDecksYet,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return Obx(
                      () => RefreshIndicator(
                        color: AppColors.primary,
                        onRefresh: () async => controller.getAllDecks(),
                        child: ListView.builder(
                          itemCount: controller.searchResults.length,
                          padding: EdgeInsets.only(top: 2.h),
                          itemBuilder: (context, index) {
                            return _CustomDeckCardItem(
                                index: index, context: context);
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
      floatingActionButton: _CustomFAB(
        onTap: () async {
          controller.createDeckBottomSheet(context);
        },
      ),
    );
  }

  // DECK CARD ITEM
  Bounceable _CustomDeckCardItem(
      {required int index, required BuildContext context}) {
    return Bounceable(
      onTap: () {
        Get.closeCurrentSnackbar();
        Get.toNamed(
          Routes.FLASHCARDPAGE,
          arguments: [
            controller.allDecks[index].content,
          ],
        );
      },
      child: SwipeActionCell(
        backgroundColor: Colors.transparent,
        key: ValueKey(controller.searchResults[index].id),
        trailingActions: <SwipeAction>[
          _SwipeAction(
            title: AppStrings.delete,
            icon: Icons.delete_outlined,
            onTap: () {
              controller.deleteDeck(index);
            },
          ),
          _SwipeAction(
            hasHandler: true,
            title: AppStrings.edit,
            icon: Icons.edit_outlined,
            onTap: () {
              controller.deckNameController.text =
                  controller.searchResults[index].name;
              controller.deckDescriptionController.text =
                  controller.searchResults[index].desc;
              controller.editDeckBottomSheet(context, index);
            },
            color: AppColors.santasGrey,
          ),
          _SwipeAction(
            title: AppStrings.addCard,
            icon: Icons.add,
            onTap: () {
              controller.flashCardRemoveText();
              controller.addCardToDeck(context, index);
            },
            color: AppColors.approvalGreen,
            hasHandler: true,
          ),
        ],
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: .5.h,
          ),
          decoration: BoxDecoration(
            color: AppColors.santasGrey.withOpacity(.15),
            borderRadius: AppBorderRadius.generalRadius,
          ),
          padding: AppPaddings.h3v1Padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.searchResults[index].name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                controller.searchResults[index].desc,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Swipe Action Buttons
  SwipeAction _SwipeAction({
    required String title,
    required IconData icon,
    required void Function() onTap,
    Color? color,
    bool hasHandler = false,
  }) {
    return SwipeAction(
      forceAlignmentToBoundary: true,
      backgroundRadius: 6.sp,
      title: title,
      icon: Icon(
        icon,
        color: AppColors.white,
      ),
      style: TextStyle(
        fontSize: 10.sp,
        color: AppColors.white,
        fontFamily: AppFonts.medium,
      ),
      onTap: (CompletionHandler handler) async {
        hasHandler ? null : await handler(true);
        onTap();
      },
      color: color ?? AppColors.red,
    );
  }
}

class _SearchInput extends StatelessWidget {
  const _SearchInput({
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.titleMedium,
      onTapOutside: (event) => controller.searchFocusNode.unfocus(),
      cursorColor: AppColors.black,
      cursorHeight: 2.h,
      focusNode: controller.searchFocusNode,
      controller: controller.searchController,
      onChanged: (value) {
        controller.searchController.addListener(() {
          controller.searchQuery.value = controller.searchController.text;
          controller.searchDecks();
        });
      },
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search_outlined,
          color: AppColors.santasGrey,
        ),
        hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.santasGrey,
            ),
        hintText: AppStrings.searchFieldHint,
        contentPadding: AppPaddings.h3v1Padding,
      ),
    );
  }
}

class _CustomFAB extends StatelessWidget {
  final void Function() onTap;
  const _CustomFAB({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      icon: Icon(
        Icons.add,
        color: AppColors.white,
      ),
      extendedPadding: EdgeInsets.symmetric(
        horizontal: 2.w,
      ),
      backgroundColor: AppColors.primary,
      splashColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: AppBorderRadius.generalRadius,
      ),
      onPressed: onTap,
      label: Text(
        AppStrings.addDeck,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
