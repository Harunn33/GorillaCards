import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../di.dart';
import '../../models/deckModel.dart';
import '../../modules/Home/HomeController.dart';
import '../constants/colors.dart';
import '../constants/spacer.dart';
import '../constants/strings.dart';
import '../methods/CustomSnackbar.dart';
import 'CustomButton.dart';
import 'CustomFlashCard.dart';
import 'CustomInputLabel.dart';
import 'CustomModalBottomSheetTextFormField.dart';

class CustomCreateFlashCard extends StatelessWidget {
  const CustomCreateFlashCard({
    super.key,
    required this.focusNode,
    required this.controller,
    required this.cardKey,
    required this.label,
    required this.btnText,
    required this.hint,
    required this.onTapOutside,
    required this.homeController,
    required this.index,
    required this.uid,
  });

  final FocusNode focusNode;
  final TextEditingController controller;
  final GlobalKey<FlipCardState> cardKey;
  final String label;
  final String btnText;
  final String hint;
  final void Function(PointerDownEvent)? onTapOutside;
  final HomeController homeController;
  final int index;
  final String? uid;

  @override
  Widget build(BuildContext context) {
    return CustomFlashCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomInputLabel(label: label),
          AppSpacer.h1,
          CustomModalBottomSheetTextFormField(
            autoFocus: true,
            actionType: cardKey.currentState!.isFront
                ? TextInputAction.next
                : TextInputAction.done,
            submit: (p0) {
              if (cardKey.currentState!.isFront) {
                cardKey.currentState?.toggleCard();
              } else {
                _addCard(homeController, index, uid);
              }
              return null;
            },
            onTapOutside: onTapOutside,
            hintText: hint,
            focusNode: focusNode,
            controller: controller,
          ),
          AppSpacer.h3,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                onTap: () => cardKey.currentState?.toggleCard(),
                text: btnText,
                bg: AppColors.primary,
                textColor: AppColors.white,
              ),
              CustomButton(
                onTap: () => _addCard(homeController, index, uid),
                text: AppStrings.ok,
                bg: AppColors.primary,
                textColor: AppColors.white,
              ),
            ],
          )
        ],
      ),
    );
  }
}

Future<void> _addCard(
    HomeController homeController, int index, String? uid) async {
  if (homeController.frontCardController.text.isNotEmpty ||
      homeController.backCardController.text.isNotEmpty) {
    final Content flashCard = Content(
      id: homeController.allDecks[index].content.length + 1,
      front: homeController.frontCardController.text,
      back: homeController.backCardController.text,
    );
    List<dynamic> list = await supabase
        .from("decks")
        .select("content")
        .eq("uid", uid)
        .eq("id", homeController.searchResults[index].id);
    list[0]["content"].add(flashCard.toJson());
    await supabase
        .from("decks")
        .update(list[0])
        .eq("uid", uid)
        .eq("id", homeController.searchResults[index].id);
    homeController.allDecks[index].content.add(flashCard);
    Get.back();
    CustomSnackbar(
      title: AppStrings.success,
      message: AppStrings.successAddFlashCard,
      type: SnackbarType.success,
    );
  }
}
