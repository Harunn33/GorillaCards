// To parse this JSON data, do
// ignore_for_file: file_names

import 'dart:convert';

TrueFalseQuestionModel trueFalseQuestionModelFromJson(String str) =>
    TrueFalseQuestionModel.fromJson(json.decode(str));

String trueFalseQuestionModelToJson(TrueFalseQuestionModel data) =>
    json.encode(data.toJson());

class TrueFalseQuestionModel {
  int id;
  String level;
  String questionType;
  List<TrueFalseQuestionList> questionList;

  TrueFalseQuestionModel({
    required this.id,
    required this.level,
    required this.questionType,
    required this.questionList,
  });

  factory TrueFalseQuestionModel.fromJson(Map<String, dynamic> json) =>
      TrueFalseQuestionModel(
        id: json["id"],
        level: json["level"],
        questionType: json["question_type"],
        questionList: List<TrueFalseQuestionList>.from(json["question_list"]
            .map((x) => TrueFalseQuestionList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "level": level,
        "question_type": questionType,
        "question_list":
            List<dynamic>.from(questionList.map((x) => x.toJson())),
      };
}

class TrueFalseQuestionList {
  int id;
  String question;
  String answer;
  String equivalent;
  bool answerBoolType;

  TrueFalseQuestionList({
    required this.id,
    required this.question,
    required this.answer,
    required this.equivalent,
    required this.answerBoolType,
  });

  factory TrueFalseQuestionList.fromJson(Map<String, dynamic> json) =>
      TrueFalseQuestionList(
        id: json["id"],
        question: json["question"],
        answer: json["answer"],
        equivalent: json["equivalent"],
        answerBoolType: json["answerBoolType"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "answer": answer,
        "equivalent": equivalent,
        "answerBoolType": answerBoolType,
      };
}
