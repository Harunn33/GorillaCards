// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorillacards/data/model/CreateDeckModel.dart';
import 'package:gorillacards/data/network/api/CreateDeckApi.dart';
import 'package:gorillacards/models/deckModel.dart';
import 'package:gorillacards/models/flashCardModel.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/methods/CustomLoadingDialog.dart';
import 'package:gorillacards/shared/methods/CustomModalBottomSheet.dart';
import 'package:gorillacards/shared/methods/CustomSnackbar.dart';

import '../Signin/SigninController.dart';

class HomeController extends GetxController {
  final CreateDeckApi _createDeckApi = CreateDeckApi();

  FocusNode deckNameFocusNode = FocusNode();
  FocusNode deckDescriptionFocuNode = FocusNode();
  FocusNode searchFocusNode = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> editFormKey = GlobalKey<FormState>();

  final SigninController signinController = SigninController();

  TextEditingController deckNameController = TextEditingController();
  TextEditingController deckDescriptionController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  RxBool buttonDisabled = false.obs;
  RxString searchQuery = "".obs;
  RxList<Deck> searchResults = <Deck>[].obs;

  @override
  void onInit() {
    super.onInit();
    searchDecks();
  }

// ALL INPUT UNFOCUS
  void allFocusNodeUnfocus() {
    deckNameFocusNode.unfocus();
    deckDescriptionFocuNode.unfocus();
    searchFocusNode.unfocus();
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
      onTap: () {
        if (formKey.currentState!.validate()) {
          // handleCreateDeck();
          final Deck newDeck = Deck(
              deckNameController.text, deckDescriptionController.text, [], 4);
          allDecks.add(newDeck);
          searchDecks();
          Get.back();
        }
      },
      submit: (p0) {
        if (formKey.currentState!.validate()) {
          // handleCreateDeck();
          final Deck newDeck = Deck(
              deckNameController.text, deckDescriptionController.text, [], 4);
          allDecks.add(newDeck);
          searchDecks();
          Get.back();
        }
        return null;
      },
    );
  }

// EDIT DECK
  void editDeck(
    BuildContext context,
    int index,
  ) {
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
      onTap: () {
        if (formKey.currentState!.validate()) {
          searchResults[index].name = deckNameController.text;
          searchResults[index].desc = deckDescriptionController.text;
          searchDecks();
          Get.back();
        }
      },
      submit: (p0) {
        if (formKey.currentState!.validate()) {
          searchResults[index].name = deckNameController.text;
          searchResults[index].desc = deckDescriptionController.text;
          searchDecks();
          Get.back();
        }
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
      message: "The deck was successfully deleted",
      type: SnackbarType.success,
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
    Deck(
      "First Deck",
      "First Deck Desc",
      [
        FlashCard("Deneme a", "Deneme s"),
      ],
      1,
    ),
    Deck(
      "Second Deck",
      "Second Deck Desc",
      [
        FlashCard("Deneme 1", "Deneme 2"),
        FlashCard("Deneme 3", "Deneme 4"),
      ],
      2,
    ),
    Deck(
      "Third Deck",
      "Third Deck Desc",
      [
        FlashCard("Deneme 5", "Deneme 6"),
        FlashCard("Deneme 7", "Deneme 8"),
        FlashCard("Deneme 9", "Deneme 10")
      ],
      3,
    ),
    Deck(
      "Fourth Deck",
      "Fourth Deck Desc",
      [
        FlashCard("Deneme 11", "Deneme 12"),
      ],
      4,
    ),
  ].obs;
}
