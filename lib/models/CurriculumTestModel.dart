// // ignore_for_file: file_names

// import 'dart:convert';

// CurriculumTestModel curriculumTestModelFromJson(String str) =>
//     CurriculumTestModel.fromJson(json.decode(str));

// String curriculumTestModelToJson(CurriculumTestModel data) =>
//     json.encode(data.toJson());

// class CurriculumTestModel {
//   int id;
//   String questionType;
//   String level;
//   String question;
//   String answer;
//   Options options;

//   CurriculumTestModel({
//     required this.id,
//     required this.questionType,
//     required this.level,
//     required this.question,
//     required this.answer,
//     required this.options,
//   });

//   factory CurriculumTestModel.fromJson(Map<String, dynamic> json) =>
//       CurriculumTestModel(
//         id: json["id"],
//         questionType: json["question_type"],
//         level: json["level"],
//         question: json["question"],
//         answer: json["answer"],
//         options: Options.fromJson(json["options"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "question_type": questionType,
//         "level": level,
//         "question": question,
//         "answer": answer,
//         "options": options.toJson(),
//       };
// }

// class Options {
//   String a;
//   String b;
//   String c;
//   String d;

//   Options({
//     required this.a,
//     required this.b,
//     required this.c,
//     required this.d,
//   });

//   factory Options.fromJson(Map<String, dynamic> json) => Options(
//         a: json["a"],
//         b: json["b"],
//         c: json["c"],
//         d: json["d"],
//       );

//   Map<String, dynamic> toJson() => {
//         "a": a,
//         "b": b,
//         "c": c,
//         "d": d,
//       };
// }

// To parse this JSON data, do
//
//     final curriculumTestModel = curriculumTestModelFromJson(jsonString);

import 'dart:convert';

List<CurriculumTestModel> curriculumTestModelFromJson(String str) =>
    List<CurriculumTestModel>.from(
        json.decode(str).map((x) => CurriculumTestModel.fromJson(x)));

String curriculumTestModelToJson(List<CurriculumTestModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CurriculumTestModel {
  int id;
  String level;
  List<QuestionList> questionList;

  CurriculumTestModel({
    required this.id,
    required this.level,
    required this.questionList,
  });

  factory CurriculumTestModel.fromJson(Map<String, dynamic> json) =>
      CurriculumTestModel(
        id: json["id"],
        level: json["level"],
        questionList: List<QuestionList>.from(
            json["questionList"].map((x) => QuestionList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "level": level,
        "questionList": List<dynamic>.from(questionList.map((x) => x.toJson())),
      };
}

class QuestionList {
  int id;
  String question;
  String questionType;
  String answer;
  Options options;

  QuestionList({
    required this.id,
    required this.question,
    required this.questionType,
    required this.answer,
    required this.options,
  });

  factory QuestionList.fromJson(Map<String, dynamic> json) => QuestionList(
        id: json["id"],
        question: json["question"],
        questionType: json["question_type"],
        answer: json["answer"],
        options: Options.fromJson(json["options"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "question_type": questionType,
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
