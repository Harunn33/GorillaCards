// ignore_for_file: file_names

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorillacards/data/model/CreateDeckModel.dart';
import 'package:gorillacards/data/network/api/CreateDeckApi.dart';
import 'package:gorillacards/models/deckModel.dart';
import 'package:gorillacards/shared/constants/colors.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/methods/CustomLoadingDialog.dart';
import 'package:gorillacards/shared/methods/CustomModalBottomSheet.dart';
import 'package:gorillacards/shared/methods/CustomSnackbar.dart';
import 'package:gorillacards/shared/widgets/CustomButton.dart';
import 'package:gorillacards/shared/widgets/CustomFlashCard.dart';
import 'package:gorillacards/shared/widgets/CustomModalBottomSheetTextFormField.dart';
import 'package:sizer/sizer.dart';

import '../../di.dart';
import '../../shared/constants/spacer.dart';
import '../../shared/widgets/CustomInputLabel.dart';
import '../Signin/SigninController.dart';

class HomeController extends GetxController {
  final CreateDeckApi _createDeckApi = CreateDeckApi();

  FocusNode deckNameFocusNode = FocusNode();
  FocusNode deckDescriptionFocuNode = FocusNode();
  FocusNode searchFocusNode = FocusNode();
  FocusNode frontCardFocusNode = FocusNode();
  FocusNode backCardFocusNode = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  final SigninController signinController = SigninController();

  TextEditingController deckNameController = TextEditingController();
  TextEditingController deckDescriptionController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController frontCardController = TextEditingController();
  TextEditingController backCardController = TextEditingController();

  RxBool buttonDisabled = false.obs;
  RxString searchQuery = "".obs;
  RxList<Deck> searchResults = <Deck>[].obs;

  @override
  void onInit() {
    super.onInit();
    searchDecks();
  }

  Future<void> getAllDecks() async {
    final data = await supabase.from("decks").select();
    for (var i = 0; i < data.length; i++) {
      final Deck newDeck = Deck(
          id: data[i]["id"],
          name: data[i]["name"],
          desc: data[i]["desc"],
          content: <Content>[]);
      for (var j = 0; j < data[i]["content"].length; j++) {
        newDeck.content.add(
          Content(
            id: data[i]["content"][j]["id"],
            front: data[i]["content"][j]["front"],
            back: data[i]["content"][j]["back"],
          ),
        );
      }
      allDecks.add(newDeck);
      searchDecks();
    }
  }

// FLASH CARD INPUT TEXT REMOVE
  void flashCardRemoveText() {
    frontCardController.clear();
    backCardController.clear();
  }

// FLASH CARD INPUT UNFOCUS
  void flashCardFocusNodeUnfocus() {
    frontCardFocusNode.unfocus();
    backCardFocusNode.unfocus();
  }

// ALL INPUT UNFOCUS
  void allFocusNodeUnfocus() {
    deckNameFocusNode.unfocus();
    deckDescriptionFocuNode.unfocus();
  }

// ALL INPUT TEXT REMOVE
  void allRemoveText() {
    deckNameController.clear();
    deckDescriptionController.clear();
  }

// CREATE DECK REQUEST
  void handleCreateDeck() async {
    buttonDisabled.value = true;
    await Get.closeCurrentSnackbar();
    CustomLoadingDialog();
    final CreateDeckModel createDeckModel = CreateDeckModel(
      name: deckNameController.text,
      description: deckDescriptionController.text,
    );
    try {
      final response = await _createDeckApi.postCreateDeck(
        data: createDeckModel.toJson(),
        token: "Bearer ${signinController.box.read("token").toString()}",
      );
      if (response.statusCode == 201) {
        buttonDisabled.value = false;
        Get.close(2);
        allRemoveText();
        CustomSnackbar(
          title: AppStrings.success,
          message: AppStrings.createdDeckSuccessMessage,
          type: SnackbarType.success,
        );
      }
    } catch (e) {
      buttonDisabled.value = false;
      Get.back();
      CustomSnackbar(
        title: AppStrings.error,
        message: AppStrings.createdDeckErrorMessage,
      );
    }
  }

// CREATE DECK BOTTOM SHEET
  void createDeck(BuildContext context) {
    Get.closeCurrentSnackbar();
    CustomModalBottomSheet(
      context: context,
      formKey: formKey,
      onTapOutside: (p0) => allFocusNodeUnfocus(),
      deckNameFocusNode: deckNameFocusNode,
      deckDescriptionFocuNode: deckDescriptionFocuNode,
      deckNameController: deckNameController,
      deckDescriptionController: deckDescriptionController,
      onTap: () => _handleCreateDeck(formKey, deckNameController,
          deckDescriptionController, allDecks, searchDecks),
      submit: (p0) {
        _handleCreateDeck(formKey, deckNameController,
            deckDescriptionController, allDecks, searchDecks);
        return null;
      },
    );
  }

// EDIT DECK
  void editDeck(BuildContext context, int index) {
    Get.closeCurrentSnackbar();
    CustomModalBottomSheet(
      context: context,
      formKey: formKey,
      onTapOutside: (p0) => allFocusNodeUnfocus(),
      deckNameFocusNode: deckNameFocusNode,
      deckDescriptionFocuNode: deckDescriptionFocuNode,
      deckNameController: deckNameController,
      deckDescriptionController: deckDescriptionController,
      isEditButton: true,
      onTap: () => _handleEditDeck(formKey, searchResults, index,
          deckNameController, deckDescriptionController, searchDecks),
      submit: (p0) {
        _handleEditDeck(formKey, searchResults, index, deckNameController,
            deckDescriptionController, searchDecks);
        return null;
      },
    );
  }

// DELETE DECK
  void deleteDeck(int index) {
    Get.closeCurrentSnackbar();
    searchResults.removeAt(index);
    allDecks.removeAt(index);
    CustomSnackbar(
      title: AppStrings.success,
      message: AppStrings.successDeleteDeck,
      type: SnackbarType.success,
    );
  }

// ADD CARD TO DECK
  void addCardToDeck(BuildContext context, int index) {
    Get.closeCurrentSnackbar();
    showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 30.h,
          ),
          child: Material(
            color: Colors.transparent,
            child: FlipCard(
              key: cardKey,
              flipOnTouch: false,
              fill: Fill.fillBack,
              direction: FlipDirection.HORIZONTAL,
              side: CardSide.FRONT,
              front: _CustomCreateFlashCard(
                label: "Front Card",
                btnText: "Turn the back",
                hint: "Front Card Text",
                focusNode: frontCardFocusNode,
                controller: frontCardController,
                cardKey: cardKey,
                onTapOutside: (p0) => flashCardFocusNodeUnfocus(),
                homeController: this,
                index: index,
              ),
              back: _CustomCreateFlashCard(
                focusNode: backCardFocusNode,
                controller: backCardController,
                cardKey: cardKey,
                label: "Back Card",
                btnText: "Turn the front",
                hint: "Back Card Text",
                onTapOutside: (p0) => flashCardFocusNodeUnfocus(),
                homeController: this,
                index: index,
              ),
            ),
          ),
        );
      },
    );
  }

// SEARCH DECK
  void searchDecks() {
    searchResults.clear();

    if (searchQuery.isEmpty) {
      searchResults.addAll(allDecks);
      return;
    }

    for (var deck in allDecks) {
      if (deck.name.toLowerCase().contains(searchQuery.value.toLowerCase())) {
        searchResults.add(deck);
      }
    }
  }

  RxList<Deck> allDecks = <Deck>[
    // Deck(
    //   name: "First Deck",
    //   desc: "First Deck Desc",
    //   content: [],
    //   id: 1,
    // ),
    // Deck(
    //   name: "Second Deck",
    //   desc: "Second Deck Desc",
    //   content: [],
    //   id: 2,
    // ),
    // Deck(
    //   name: "Third Deck",
    //   desc: "Third Deck Desc",
    //   content: [],
    //   id: 3,
    // ),
    // Deck(
    //   name: "Fourth Deck",
    //   desc: "Fourth Deck Desc",
    //   content: [],
    //   id: 4,
    // ),
  ].obs;
}

// Custom Create Flashcard Widget
class _CustomCreateFlashCard extends StatelessWidget {
  const _CustomCreateFlashCard({
    required this.focusNode,
    required this.controller,
    required this.cardKey,
    required this.label,
    required this.btnText,
    required this.hint,
    required this.onTapOutside,
    required this.homeController,
    required this.index,
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
                _addCard(homeController, index);
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
                onTap: () => _addCard(homeController, index),
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

// Add Flashcard
void _addCard(HomeController homeController, int index) {
  if (homeController.frontCardController.text.isNotEmpty ||
      homeController.backCardController.text.isNotEmpty) {
    final Content flashCard = Content(
      id: 1,
      front: homeController.frontCardController.text,
      back: homeController.backCardController.text,
    );
    homeController.allDecks[index].content.add(flashCard);
    Get.back();
    CustomSnackbar(
      title: AppStrings.success,
      message: AppStrings.successAddFlashCard,
      type: SnackbarType.success,
    );
  }
}

void _handleEditDeck(
  GlobalKey<FormState> formKey,
  RxList<Deck> searchResults,
  int index,
  TextEditingController deckNameController,
  TextEditingController deckDescriptionController,
  Function searchDecks,
) {
  if (formKey.currentState!.validate()) {
    searchResults[index].name = deckNameController.text;
    searchResults[index].desc = deckDescriptionController.text;
    searchDecks();
    Get.back();
    CustomSnackbar(
      title: AppStrings.success,
      message: AppStrings.successEditDeck,
      type: SnackbarType.success,
    );
  }
}

void _handleCreateDeck(
  GlobalKey<FormState> formKey,
  TextEditingController deckNameController,
  TextEditingController deckDescriptionController,
  RxList<Deck> allDecks,
  Function searchDecks,
) {
  if (formKey.currentState!.validate()) {
    final Deck newDeck = Deck(
        id: 4,
        name: deckNameController.text,
        desc: deckDescriptionController.text,
        content: []);
    allDecks.add(newDeck);
    searchDecks();
    Get.back();
    CustomSnackbar(
      title: AppStrings.success,
      message: AppStrings.successCreateDeck,
      type: SnackbarType.success,
    );
  }
}
