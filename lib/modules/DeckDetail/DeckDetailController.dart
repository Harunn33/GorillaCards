// ignore_for_file: file_names

import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorillacards/di.dart';
import 'package:gorillacards/models/deckModel.dart';
import 'package:gorillacards/modules/Home/HomeController.dart';
import 'package:gorillacards/shared/constants/colors.dart';
import 'package:gorillacards/shared/constants/spacer.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/methods/CustomSnackbar.dart';
import 'package:gorillacards/shared/widgets/CustomButton.dart';
import 'package:gorillacards/shared/widgets/CustomCreateFlashCardWidget.dart';
import 'package:gorillacards/shared/widgets/CustomFlashCard.dart';
import 'package:gorillacards/shared/widgets/CustomInputLabel.dart';
import 'package:gorillacards/shared/widgets/CustomModalBottomSheetTextFormField.dart';
import 'package:sizer/sizer.dart';

class DeckDetailController extends GetxController {
  TextEditingController frontCardController = TextEditingController();
  TextEditingController backCardController = TextEditingController();

  FocusNode frontCardFocusNode = FocusNode();
  FocusNode backCardFocusNode = FocusNode();

  RxBool isLoading = false.obs;

  final FlipCardController flipCardController = FlipCardController();
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  final HomeController homeController = Get.find();

  RxList<Content> flashCards = <Content>[].obs;

  @override
  void onInit() {
    super.onInit();
    flashCards.addAll(Get.arguments[0]);
  }

  void editFlashCard(BuildContext context, int index, int deckId) {
    Get.closeCurrentSnackbar();
    frontCardController.text = flashCards[index].front;
    backCardController.text = flashCards[index].back;
    showDialog(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 35.h,
          ),
          child: Material(
            color: Colors.transparent,
            child: FlipCard(
              key: cardKey,
              flipOnTouch: false,
              fill: Fill.fillBack,
              direction: FlipDirection.HORIZONTAL,
              side: CardSide.FRONT,
              front: _CustomFlashCardSide(
                cardKey: cardKey,
                isLoading: isLoading,
                focusNode: frontCardFocusNode,
                textEditingController: frontCardController,
                label: "Front Card",
                hintText: "Front Card Text",
                btnText: "Turn the back",
                onTap: () => _editCard(
                    homeController, index, deckId, homeController.uid),
                submit: (p0) => _editCard(
                    homeController, index, deckId, homeController.uid),
              ),
              back: _CustomFlashCardSide(
                cardKey: cardKey,
                isLoading: isLoading,
                focusNode: backCardFocusNode,
                textEditingController: backCardController,
                label: "Back Card",
                hintText: "Back Card Text",
                btnText: "Turn the front",
                onTap: () => _editCard(
                    homeController, index, deckId, homeController.uid),
                submit: (p0) => _editCard(
                    homeController, index, deckId, homeController.uid),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> deleteCard(int index, int deckId, String? uid) async {
    try {
      List<dynamic> list = await supabase
          .from("decks")
          .select("content")
          .eq("uid", uid)
          .eq("id", deckId);
      list[0]["content"].removeAt(index);
      await supabase
          .from("decks")
          .update(list[0])
          .eq("uid", uid)
          .eq("id", deckId);
      flashCards.removeAt(index);
      CustomSnackbar(
        title: AppStrings.success,
        message: AppStrings.successDeleteFlashCard,
        type: SnackbarType.success,
      );
    } catch (e) {
      isLoading.toggle();
      CustomSnackbar(
        title: AppStrings.error,
        message: e.toString(),
        type: SnackbarType.error,
      );
    }
  }

  Future<void> _editCard(
    HomeController homeController,
    int index,
    int deckId,
    String? uid,
  ) async {
    if (frontCardController.text.isNotEmpty ||
        backCardController.text.isNotEmpty) {
      final Content flashCard = Content(
        id: index + 1,
        front: frontCardController.text,
        back: backCardController.text,
      );
      try {
        List<dynamic> list = await supabase
            .from("decks")
            .select("content")
            .eq("uid", uid)
            .eq("id", deckId);
        list[0]["content"].removeAt(index);
        list[0]["content"].add(flashCard.toJson());
        list[0]["content"].sort((a, b) => int.parse(a["id"].toString())
            .compareTo(int.parse(b["id"].toString())));
        await supabase
            .from("decks")
            .update(list[0])
            .eq("uid", uid)
            .eq("id", deckId);
        flashCards.removeAt(index);
        flashCards.add(flashCard);
        flashCards.sort(
          (a, b) => a.id.compareTo(b.id),
        );
        Get.back();
        CustomSnackbar(
          title: AppStrings.success,
          message: AppStrings.successAddFlashCard,
          type: SnackbarType.success,
        );
      } catch (e) {
        isLoading.toggle();
        CustomSnackbar(
          title: AppStrings.error,
          message: e.toString(),
          type: SnackbarType.error,
        );
      }
    }
    isLoading.toggle();
  }
}

class _CustomFlashCardSide extends StatelessWidget {
  const _CustomFlashCardSide({
    required this.cardKey,
    required this.isLoading,
    required this.focusNode,
    required this.textEditingController,
    required this.label,
    required this.hintText,
    required this.btnText,
    required this.onTap,
    required this.submit,
  });

  final GlobalKey<FlipCardState> cardKey;
  final RxBool isLoading;
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final String label;
  final String hintText;
  final String btnText;
  final void Function() onTap;
  final void Function(String) submit;

  @override
  Widget build(BuildContext context) {
    return CustomFlashCard(
      height: 21.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CustomInputLabel(
              label: label,
            ),
          ),
          AppSpacer.h1,
          Obx(
            () => CustomModalBottomSheetTextFormField(
              autoFocus: true,
              actionType: cardKey.currentState!.isFront
                  ? TextInputAction.next
                  : TextInputAction.done,
              submit: isLoading.value
                  ? null
                  : (p0) {
                      if (cardKey.currentState!.isFront) {
                        cardKey.currentState?.toggleCard();
                      } else {
                        isLoading.toggle();
                        submit(p0);
                      }
                      return null;
                    },
              onTapOutside: (p0) => focusNode.unfocus(),
              hintText: hintText,
              focusNode: focusNode,
              controller: textEditingController,
            ),
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
              Obx(
                () => CustomButton(
                  isLoading: isLoading,
                  onTap: isLoading.value
                      ? null
                      : () {
                          isLoading.toggle();
                          onTap();
                        },
                  text: AppStrings.ok,
                  bg: AppColors.primary,
                  textColor: AppColors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
