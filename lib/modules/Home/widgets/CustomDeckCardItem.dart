// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:gorillacards/modules/Home/HomeController.dart';
import 'package:gorillacards/shared/methods/CustomSnackbar.dart';
import 'package:sizer/sizer.dart';

import '../../../routes/app_pages.dart';
import '../../../shared/constants/borderRadius.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/constants/paddings.dart';
import '../../../shared/constants/strings.dart';
import 'CustomSwipeAction.dart';

class CustomDeckCardItem extends StatelessWidget {
  final HomeController controller;
  final int index;
  const CustomDeckCardItem(
      {super.key, required this.controller, required this.index});

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: _redirectToFlashCardPage,
      child: SwipeActionCell(
        backgroundColor: Colors.transparent,
        key: ValueKey(controller.searchResults[index].id),
        trailingActions: <SwipeAction>[
          CustomSwipeAction(
            title: AppStrings.delete,
            icon: Icons.delete_outlined,
            onTap: () => controller.deleteDeck(index),
          ),
          CustomSwipeAction(
            hasHandler: true,
            title: AppStrings.edit,
            icon: Icons.edit_outlined,
            onTap: () => _editFunc(context),
            color: AppColors.santasGrey,
          ),
          CustomSwipeAction(
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

  void _redirectToFlashCardPage() {
    Get.closeCurrentSnackbar();
    if (controller.allDecks[index].content.isEmpty) {
      CustomSnackbar(
          title: AppStrings.error,
          message: AppStrings.noFlashCard,
          type: SnackbarType.error);
      return;
    }
    Get.toNamed(
      Routes.FLASHCARDPAGE,
      arguments: [
        controller.allDecks[index].content,
      ],
    );
  }

  void _editFunc(BuildContext context) {
    controller.deckNameController.text = controller.searchResults[index].name;
    controller.deckDescriptionController.text =
        controller.searchResults[index].desc;
    controller.createBottomSheet(
        context: context, bottomSheetType: BottomSheetType.edit, index: index);
  }
}
