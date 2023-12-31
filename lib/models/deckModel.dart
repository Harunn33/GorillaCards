// ignore_for_file: file_names

import 'dart:convert';

Deck deckFromJson(String str) => Deck.fromJson(json.decode(str));

String deckToJson(Deck data) => json.encode(data.toJson());

class Deck {
  int id;
  String? uid;
  String name;
  String desc;
  List<Content> content;

  Deck({
    required this.id,
    required this.name,
    required this.desc,
    required this.content,
    required this.uid,
  });

  factory Deck.fromJson(Map<String, dynamic> json) => Deck(
      id: json["id"],
      name: json["name"],
      desc: json["desc"],
      content:
          List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
      uid: json["uid"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "desc": desc,
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
        "uid": uid,
      };
}

class Content {
  int id;
  String front;
  String back;

  Content({
    required this.id,
    required this.front,
    required this.back,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        front: json["front"],
        back: json["back"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "front": front,
        "back": back,
      };
}
