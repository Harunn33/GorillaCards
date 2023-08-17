// ignore_for_file: file_names

import 'package:gorillacards/models/flashCardModel.dart';

class Deck {
  final int id;
  final String name;
  final int totalItem;
  final List<FlashCard> content;

  Deck(this.name, this.totalItem, this.content, this.id);
}
