// ignore_for_file: file_names

import 'dart:convert';

CurriculumTestModel curriculumTestModelFromJson(String str) =>
    CurriculumTestModel.fromJson(json.decode(str));

String curriculumTestModelToJson(CurriculumTestModel data) =>
    json.encode(data.toJson());

class CurriculumTestModel {
  int id;
  String questionType;
  String level;
  String question;
  String answer;
  Options options;

  CurriculumTestModel({
    required this.id,
    required this.questionType,
    required this.level,
    required this.question,
    required this.answer,
    required this.options,
  });

  factory CurriculumTestModel.fromJson(Map<String, dynamic> json) =>
      CurriculumTestModel(
        id: json["id"],
        questionType: json["question_type"],
        level: json["level"],
        question: json["question"],
        answer: json["answer"],
        options: Options.fromJson(json["options"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question_type": questionType,
        "level": level,
        "question": question,
        "answer": answer,
        "options": options.toJson(),
      };
}

class Options {
  String a;
  String b;
  String c;
  String d;

  Options({
    required this.a,
    required this.b,
    required this.c,
    required this.d,
  });

  factory Options.fromJson(Map<String, dynamic> json) => Options(
        a: json["a"],
        b: json["b"],
        c: json["c"],
        d: json["d"],
      );

  Map<String, dynamic> toJson() => {
        "a": a,
        "b": b,
        "c": c,
        "d": d,
      };
}
