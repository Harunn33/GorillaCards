// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorillacards/di.dart';
import 'package:gorillacards/models/deckModel.dart';

class ReadyDeckController extends GetxController {
  FocusNode searchFocusNode = FocusNode();

  TextEditingController searchController = TextEditingController();

  RxList<Deck> readyDeckList = <Deck>[].obs;
  RxString searchQuery = "".obs;
  RxList<Deck> searchResults = <Deck>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getReadyDeck();
  }

  Future<void> getReadyDeck() async {
    isLoading.toggle();
    try {
      final list = await supabase.from("ReadyDecks").select("*");
      readyDeckList.clear();
      for (var i = 0; i < list.length; i++) {
        final Deck newDeck = Deck(
          id: list[i]["id"],
          name: list[i]["name"],
          desc: list[i]["desc"],
          content: <Content>[],
          uid: "",
        );
        for (var j = 0; j < list[i]["content"].length; j++) {
          newDeck.content.add(
            Content(
              id: int.parse(list[i]["content"][j]["id"]),
              front: list[i]["content"][j]["front"],
              back: list[i]["content"][j]["back"],
            ),
          );
        }
        readyDeckList.add(newDeck);
        searchDecks();
      }
      isLoading.toggle();
    } catch (e) {
      isLoading.toggle();
    }
  }

  void searchDecks() {
    searchResults.clear();

    if (searchQuery.isEmpty) {
      searchResults.addAll(readyDeckList);
      return;
    }

    for (var deck in readyDeckList) {
      if (deck.name.toLowerCase().contains(searchQuery.value.toLowerCase())) {
        searchResults.add(deck);
      }
    }
  }

  Color getReadyDeckBgColor(String deckName) {
    switch (deckName) {
      case "Classics":
        return const Color(0xFFFF5733);
      case "Business":
        return const Color(0xFF3498DB);
      case "Humor":
        return const Color(0xFFFFC300);
      case "History":
        return const Color(0xFF9B59B6);
      case "Marketing":
        return const Color(0xFF27AE60);
      case "Romance":
        return const Color(0xFFE74C3C);
      default:
        return const Color(0xFFFFFFFF);
    }
  }
}

enum ReadyDeckType {
  business("BusinessReadyDeck"),
  classics("ClassicsReadyDeck"),
  history("HistoryReadyDeck"),
  humor("HumorReadyDeck"),
  marketing("MarketingReadyDeck"),
  romance("RomanceReadyDeck");

  final String value;
  const ReadyDeckType(this.value);

  String get type => value;
  String get deckName => value.split("ReadyDeck")[0].capitalizeFirst.toString();
}
