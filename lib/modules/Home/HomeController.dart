// ignore_for_file: file_names

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorillacards/models/deckModel.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/methods/CustomModalBottomSheet.dart';
import 'package:gorillacards/shared/methods/CustomSnackbar.dart';
import 'package:sizer/sizer.dart';

import '../../di.dart';
import '../../shared/widgets/CustomCreateFlashCardWidget.dart';
import '../Signin/SigninController.dart';

class HomeController extends GetxController {
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
  RxList<Deck> allDecks = <Deck>[].obs;

  final String? uid = supabase.auth.currentSession?.user.id;

  // GET ALL DECKS FOR USERS
  Future<void> getAllDecks() async {
    final data = await supabase.from("decks").select().filter("uid", "eq", uid);
    allDecks.clear();
    for (var i = 0; i < data.length; i++) {
      final Deck newDeck = Deck(
        id: data[i]["id"],
        name: data[i]["name"],
        desc: data[i]["desc"],
        content: <Content>[],
        uid: data[i]["uid"],
      );
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

  @override
  void onClose() {
    super.onClose();
    deckNameController.dispose();
    deckDescriptionController.dispose();
    searchController.dispose();
    frontCardController.dispose();
    backCardController.dispose();
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

// CREATE DECK
  Future<void> handleCreateDeck(
    GlobalKey<FormState> formKey,
    TextEditingController deckNameController,
    TextEditingController deckDescriptionController,
    RxList<Deck> allDecks,
    Function searchDecks,
  ) async {
    if (formKey.currentState!.validate()) {
      final lastId = await supabase
          .from("decks")
          .select("id")
          .order("id", ascending: false)
          .limit(1);
      final Deck newDeck = Deck(
        id: lastId[0]["id"] + 1,
        name: deckNameController.text,
        desc: deckDescriptionController.text,
        content: [],
        uid: uid,
      );
      await supabase.from("decks").insert(newDeck.toJson());
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

// EDIT DECK
  Future<void> handleEditDeck(
    GlobalKey<FormState> formKey,
    RxList<Deck> searchResults,
    int index,
    TextEditingController deckNameController,
    TextEditingController deckDescriptionController,
    Function searchDecks,
  ) async {
    if (formKey.currentState!.validate()) {
      searchResults[index].name = deckNameController.text;
      searchResults[index].desc = deckDescriptionController.text;
      await supabase
          .from("decks")
          .update({
            "name": deckNameController.text,
            "desc": deckDescriptionController.text
          })
          .eq("id", searchResults[index].id)
          .eq("uid", uid);
      searchDecks();
      Get.back();
      CustomSnackbar(
        title: AppStrings.success,
        message: AppStrings.successEditDeck,
        type: SnackbarType.success,
      );
    }
  }

// CREATE/EDIT DECK BOTTOM SHEET
  void createBottomSheet(
      {required BuildContext context,
      int? index,
      BottomSheetType bottomSheetType = BottomSheetType.create}) {
    Get.closeCurrentSnackbar();
    bottomSheetType == BottomSheetType.create ? allRemoveText() : null;
    CustomModalBottomSheet(
      context: context,
      formKey: formKey,
      onTapOutside: (p0) => allFocusNodeUnfocus(),
      deckNameFocusNode: deckNameFocusNode,
      deckDescriptionFocuNode: deckDescriptionFocuNode,
      deckNameController: deckNameController,
      deckDescriptionController: deckDescriptionController,
      isEditButton: bottomSheetType == BottomSheetType.edit ? true : false,
      onTap: () {
        bottomSheetType == BottomSheetType.create
            ? handleCreateDeck(formKey, deckNameController,
                deckDescriptionController, allDecks, searchDecks)
            : handleEditDeck(formKey, searchResults, index ?? 0,
                deckNameController, deckDescriptionController, searchDecks);
      },
      submit: (p0) {
        bottomSheetType == BottomSheetType.create
            ? handleCreateDeck(formKey, deckNameController,
                deckDescriptionController, allDecks, searchDecks)
            : handleEditDeck(formKey, searchResults, index ?? 0,
                deckNameController, deckDescriptionController, searchDecks);
        return null;
      },
    );
  }

// DELETE DECK
  Future<void> deleteDeck(int index) async {
    Get.closeCurrentSnackbar();
    await supabase
        .from("decks")
        .delete()
        .eq("id", searchResults[index].id)
        .eq("uid", uid);
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
              front: CustomCreateFlashCard(
                label: "Front Card",
                btnText: "Turn the back",
                hint: "Front Card Text",
                focusNode: frontCardFocusNode,
                controller: frontCardController,
                cardKey: cardKey,
                onTapOutside: (p0) => flashCardFocusNodeUnfocus(),
                homeController: this,
                index: index,
                uid: uid,
              ),
              back: CustomCreateFlashCard(
                focusNode: backCardFocusNode,
                controller: backCardController,
                cardKey: cardKey,
                label: "Back Card",
                btnText: "Turn the front",
                hint: "Back Card Text",
                onTapOutside: (p0) => flashCardFocusNodeUnfocus(),
                homeController: this,
                index: index,
                uid: uid,
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
}

enum BottomSheetType { create, edit }
