// ignore_for_file: file_names

import 'package:gorillacards/models/flashCardModel.dart';

class Deck {
  final int id;
  String name;
  String desc;
  final List<FlashCard> content;

  Deck(this.name, this.desc, this.content, this.id);
}
