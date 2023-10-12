// ignore_for_file: file_names

import 'package:card_swiper/card_swiper.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gorillacards/di.dart';
import 'package:gorillacards/models/CurriculumTestModel.dart';
import 'package:gorillacards/models/TrueFalseQuestionTypeModel.dart';
import 'package:gorillacards/modules/Curriculum/CurruiculumController.dart';
import 'package:gorillacards/shared/constants/colors.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/enums/audio.dart';
import 'package:gorillacards/shared/enums/question_type.dart';
import 'package:gorillacards/shared/methods/CustomRawSnackbar.dart';
import 'package:gorillacards/shared/widgets/TranslateQuestionType.dart';
import 'package:gorillacards/shared/widgets/TrueFalseQuestionType.dart';

class CurriculumTestPageController extends GetxController {
  RxString selectedChoice = "".obs;
  RxList<TranslateQuestionList> translateQuestionList =
      <TranslateQuestionList>[].obs;
  RxList<TrueFalseQuestionList> trueFalseQuestionList =
      <TrueFalseQuestionList>[].obs;

  final FlipCardController flipCardController = FlipCardController();
  final SwiperController swiperController = SwiperController();
  final GetStorage storage = GetStorage();
  final CurriculumController curriculumController =
      Get.find<CurriculumController>();

  final parameters = Get.parameters;

  @override
  void onInit() {
    super.onInit();
    getQuestions();
  }

  // SORULARI GETİR
  Future<void> getQuestions() async {
    final list = await supabase
        .from("Curriculum")
        .select("question_list")
        .eq("level", parameters["level"])
        .eq(
          "question_type",
          parameters["question_type"],
        );

    if (parameters["question_type"] == QuestionType.Translate.name) {
      for (var questions in list[0]["question_list"]) {
        final question = TranslateQuestionList.fromJson(questions);
        translateQuestionList.add(question);
      }
    } else if (parameters["question_type"] == QuestionType.True_False.name) {
      for (var questions in list[0]["question_list"]) {
        final question = TrueFalseQuestionList.fromJson(questions);
        trueFalseQuestionList.add(question);
      }
    }
  }

  // CEVAP KONTROLÜ
  void handleAnswerControl(BuildContext context,
      {required int index,
      required String title,
      required String equalText,
      required QuestionType questionType}) {
    selectedChoice.value = title;
    if (selectedChoice.value.toLowerCase().trim() ==
        equalText.toLowerCase().trim()) {
      PlaySounds.correct();
      CustomRawSnackbar(
        questionListLength: questionType == QuestionType.Translate
            ? translateQuestionList.length - 1
            : trueFalseQuestionList.length - 1,
        curriculumTestPageController: this,
        index: index,
        context: context,
        title: AppStrings.success.tr,
        message: AppStrings.answeredCorrect.tr,
        bg: AppColors.dustyGreen,
      );
    } else {
      flipCardController.state?.toggleCard();
      PlaySounds.wrong();
      CustomRawSnackbar(
        questionListLength: questionType == QuestionType.Translate
            ? translateQuestionList.length - 1
            : trueFalseQuestionList.length - 1,
        curriculumTestPageController: this,
        index: index,
        context: context,
        title: AppStrings.error.tr,
        message: AppStrings.answeredWrong.tr,
      );
    }
  }

  // SUPABASE DEN GELEN BOOLEAN CEVAP TÜRÜNE GÖRE DÖNÜŞTÜRME YAPIYORUM
  String checkAnswerForBoolType(bool isCorrect) {
    if (isCorrect) {
      return AppStrings.trueAnswer.tr;
    } else {
      return AppStrings.falseAnswer.tr;
    }
  }

  // ÖNCEKİ SAYFADAN GELEN SORU TİPİNE GÖRE ENUM OLARAK SORU TİPİ DÖNÜYOR
  QuestionType checkQuestionType() {
    if (QuestionType.Translate.name == parameters["question_type"]) {
      return QuestionType.Translate;
    } else if (QuestionType.True_False.name == parameters["question_type"]) {
      return QuestionType.True_False;
    }
    return QuestionType.Translate;
  }

  // ÖNCEKİ SAYFADAN GELEN SORU TİPİNE GÖRE SAYFADA GÖZÜKECEK OLAN SORU KOMPONENTİ DĞEİŞİYOR
  Widget getQuestionType(QuestionType questionType) {
    switch (questionType) {
      case QuestionType.Translate:
        return TranslateQuestionType(controller: this);
      case QuestionType.True_False:
        return TrueFalseQuestionType(controller: this);
      default:
    }
    return const SizedBox.shrink();
  }
}
