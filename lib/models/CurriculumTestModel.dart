// ignore_for_file: file_names

import 'dart:convert';

List<CurriculumTestModel> curriculumTestModelFromJson(String str) =>
    List<CurriculumTestModel>.from(
        json.decode(str).map((x) => CurriculumTestModel.fromJson(x)));

String curriculumTestModelToJson(List<CurriculumTestModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CurriculumTestModel {
  int id;
  String level;
  String questionType;
  List<TranslateQuestionList> questionList;

  CurriculumTestModel({
    required this.id,
    required this.level,
    required this.questionList,
    required this.questionType,
  });

  factory CurriculumTestModel.fromJson(Map<String, dynamic> json) =>
      CurriculumTestModel(
          id: json["id"],
          level: json["level"],
          questionList: List<TranslateQuestionList>.from(
            json["questionList"].map(
              (x) => TranslateQuestionList.fromJson(x),
            ),
          ),
          questionType: json["question_type"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "level": level,
        "questionList": List<dynamic>.from(questionList.map((x) => x.toJson())),
        "question_type": questionType
      };
}

class TranslateQuestionList {
  int id;
  String question;
  String answer;
  Options options;

  TranslateQuestionList({
    required this.id,
    required this.question,
    required this.answer,
    required this.options,
  });

  factory TranslateQuestionList.fromJson(Map<String, dynamic> json) =>
      TranslateQuestionList(
        id: json["id"],
        question: json["question"],
        answer: json["answer"],
        options: Options.fromJson(json["options"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
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
