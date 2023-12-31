// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:gorillacards/di.dart';
import 'package:gorillacards/models/deckModel.dart';
import 'package:gorillacards/modules/Home/HomeController.dart';
import 'package:gorillacards/routes/app_pages.dart';
import 'package:gorillacards/shared/constants/colors.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import 'package:gorillacards/shared/constants/spacer.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/methods/CustomSnackbar.dart';
import 'package:gorillacards/shared/widgets/CustomButton.dart';
import 'package:gorillacards/shared/widgets/CustomFlashCard.dart';
import 'package:gorillacards/shared/widgets/CustomInputLabel.dart';
import 'package:gorillacards/shared/widgets/CustomModalBottomSheetTextFormField.dart';
import 'package:sizer/sizer.dart';

class DeckDetailController extends GetxController {
  TextEditingController frontCardController = TextEditingController();
  TextEditingController backCardController = TextEditingController();

  FocusNode frontCardFocusNode = FocusNode();
  FocusNode backCardFocusNode = FocusNode();

  RxBool isLoading = false.obs;

  final FlipCardController flipCardController = FlipCardController();
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  final HomeController homeController = Get.find();

  RxList<Content> flashCards = <Content>[].obs;

  final int deckId = Get.arguments[0];

  List<dynamic> contentListFromSupabase = [];

  int deckIndex = Get.arguments[1];

  @override
  void onInit() {
    super.onInit();
    getCardList();
  }

  @override
  void onClose() {
    super.onClose();
    frontCardController.dispose();
    backCardController.dispose();
    frontCardFocusNode.dispose();
    backCardFocusNode.dispose();
  }

  Future<void> getCardList() async {
    isLoading.value = true;
    contentListFromSupabase = await supabase
        .from("decks")
        .select("content")
        .eq("uid", homeController.uid)
        .eq("id", deckId);
    for (var card in contentListFromSupabase[0]["content"]) {
      final Content cardModel =
          Content(id: card["id"], front: card["front"], back: card["back"]);
      flashCards.add(cardModel);
    }
    isLoading.value = false;
  }

  void editFlashCard(BuildContext context, int index) {
    Get.closeAllSnackbars();

    frontCardController.text = flashCards[index].front;
    backCardController.text = flashCards[index].back;
    showDialog(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 30.h,
          ),
          child: Material(
            color: Colors.transparent,
            child: FlipCard(
              key: cardKey,
              flipOnTouch: false,
              fill: Fill.fillBack,
              direction: FlipDirection.HORIZONTAL,
              side: CardSide.FRONT,
              front: _CustomFlashCardSide(
                cardKey: cardKey,
                isLoading: isLoading,
                focusNode: frontCardFocusNode,
                textEditingController: frontCardController,
                label: AppStrings.frontCard.tr,
                hintText: AppStrings.frontCardText.tr,
                btnText: AppStrings.turnTheBack.tr,
                onTap: () => handleEditCard(
                    homeController, index, deckId, homeController.uid),
                submit: (p0) => handleEditCard(
                    homeController, index, deckId, homeController.uid),
              ),
              back: _CustomFlashCardSide(
                cardKey: cardKey,
                isLoading: isLoading,
                focusNode: backCardFocusNode,
                textEditingController: backCardController,
                label: AppStrings.backCard.tr,
                hintText: AppStrings.backCardText.tr,
                btnText: AppStrings.turnTheFront.tr,
                onTap: () => handleEditCard(
                    homeController, index, deckId, homeController.uid),
                submit: (p0) => handleEditCard(
                    homeController, index, deckId, homeController.uid),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> deleteCard(int index, String? uid) async {
    Get.closeAllSnackbars();
    isLoading.toggle();
    try {
      flashCards.removeAt(index);
      contentListFromSupabase[0]["content"].removeAt(index);
      await supabase
          .from("decks")
          .update(contentListFromSupabase[0])
          .eq("uid", uid)
          .eq("id", deckId);
      CustomSnackbar(
        title: AppStrings.success.tr,
        message: AppStrings.successDeleteFlashCard.tr,
        type: SnackbarType.success,
      );
      isLoading.toggle();
    } catch (e) {
      isLoading.toggle();
      CustomSnackbar(
        title: AppStrings.error.tr,
        message: e.toString(),
        type: SnackbarType.error,
      );
    }
  }

  Future<void> handleEditCard(
    HomeController homeController,
    int index,
    int deckId,
    String? uid,
  ) async {
    Get.closeAllSnackbars();
    if (frontCardController.text.isNotEmpty ||
        backCardController.text.isNotEmpty) {
      final Content flashCard = Content(
        id: index + 1,
        front: frontCardController.text,
        back: backCardController.text,
      );
      try {
        contentListFromSupabase[0]["content"].removeAt(index);
        contentListFromSupabase[0]["content"].add(flashCard.toJson());
        contentListFromSupabase[0]["content"].sort((a, b) =>
            int.parse(a["id"].toString())
                .compareTo(int.parse(b["id"].toString())));
        await supabase
            .from("decks")
            .update(contentListFromSupabase[0])
            .eq("uid", uid)
            .eq("id", deckId);
        flashCards.removeAt(index);
        flashCards.add(flashCard);
        flashCards.sort(
          (a, b) => a.id.compareTo(b.id),
        );
        Get.back();
        CustomSnackbar(
          title: AppStrings.success.tr,
          message: AppStrings.successAddFlashCard.tr,
          type: SnackbarType.success,
        );
      } catch (e) {
        isLoading.toggle();
        CustomSnackbar(
          title: AppStrings.error.tr,
          message: e.toString(),
          type: SnackbarType.error,
        );
      }
    }
    isLoading.toggle();
  }

  void handleAddCard(
    int deckId,
    String? uid,
  ) async {
    Get.closeAllSnackbars();
    if (frontCardController.text.isNotEmpty ||
        backCardController.text.isNotEmpty) {
      int maxId = 0;

      for (var data in flashCards) {
        int currentId = data.id;
        if (currentId > maxId) {
          maxId = currentId;
        }
      }
      final Content flashCard = Content(
        id: maxId + 1,
        front: frontCardController.text,
        back: backCardController.text,
      );
      try {
        contentListFromSupabase[0]["content"].add(flashCard.toJson());
        await supabase
            .from("decks")
            .update(contentListFromSupabase[0])
            .eq("uid", uid)
            .eq("id", deckId);
        flashCards.add(flashCard);
        Get.back();
        CustomSnackbar(
          title: AppStrings.success.tr,
          message: AppStrings.successAddFlashCard.tr,
          type: SnackbarType.success,
        );
      } catch (e) {
        isLoading.toggle();
        CustomSnackbar(
          title: AppStrings.error.tr,
          message: e.toString(),
          type: SnackbarType.error,
        );
      }
    }
    isLoading.toggle();
  }

  void addFlashCard(BuildContext context) {
    Get.closeAllSnackbars();
    frontCardController.clear();
    backCardController.clear();
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            height: 30.h,
            margin: AppPaddings.generalPadding,
            child: Material(
              color: Colors.transparent,
              child: FlipCard(
                key: cardKey,
                flipOnTouch: false,
                fill: Fill.fillBack,
                direction: FlipDirection.HORIZONTAL,
                side: CardSide.FRONT,
                front: _CustomFlashCardSide(
                  cardKey: cardKey,
                  isLoading: isLoading,
                  focusNode: frontCardFocusNode,
                  textEditingController: frontCardController,
                  label: AppStrings.frontCard.tr,
                  hintText: AppStrings.frontCardText.tr,
                  btnText: AppStrings.turnTheBack.tr,
                  onTap: () => handleAddCard(deckId, homeController.uid),
                  submit: (p0) => handleAddCard(deckId, homeController.uid),
                ),
                back: _CustomFlashCardSide(
                  cardKey: cardKey,
                  isLoading: isLoading,
                  focusNode: backCardFocusNode,
                  textEditingController: backCardController,
                  label: AppStrings.backCard.tr,
                  hintText: AppStrings.backCardText.tr,
                  btnText: AppStrings.turnTheFront.tr,
                  onTap: () => handleAddCard(deckId, homeController.uid),
                  submit: (p0) => handleAddCard(deckId, homeController.uid),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void addCardFromCsv() async {
    const List<String> acceptedHeaders = ["id", "front", "back"];
    List<Map<String, dynamic>> convertedData = [];
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowedExtensions: ["csv"],
      type: FileType.custom,
    );
    if (result == null) return;
    String? filePath = result.files.first.path;
    if (filePath == null) return;
    final input = File(filePath).openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();
    List<String> headers = fields[0][0].split(';');
    // Kabul edilen başlıkları içeriyor mu kontrol et
    bool hasAcceptedHeaders = acceptedHeaders.every((acceptedHeader) {
      return headers.contains(acceptedHeader);
    });

    if (!hasAcceptedHeaders) {
      // Kabul edilmeyen başlıkları içeren dosyaları reddet
      // veya kullanıcıya hata mesajı gösterin
      CustomSnackbar(
          title: "Error", message: "The content of the file is not suitable");
      return;
    }
    for (int i = 1; i < fields.length; i++) {
      List<String> row = fields[i][0].split(';');
      Map<String, dynamic> rowData = {};
      for (int j = 0; j < headers.length; j++) {
        rowData[headers[j]] = row[j];
      }
      try {
        int maxId = 0;

        for (var data in flashCards) {
          int currentId = data.id;
          if (currentId > maxId) {
            maxId = currentId;
          }
        }
        final Content flashCard = Content(
            id: maxId + 1, back: rowData["back"], front: rowData["front"]);
        contentListFromSupabase[0]["content"].add(flashCard.toJson());
        await supabase
            .from("decks")
            .update(contentListFromSupabase[0])
            .eq("uid", homeController.uid)
            .eq("id", deckId);
        flashCards.add(flashCard);
        convertedData.add(rowData);
      } catch (e) {
        CustomSnackbar(
          title: AppStrings.error.tr,
          message: e.toString(),
          type: SnackbarType.error,
        );
      }
    }
    Get.back();
    CustomSnackbar(
      title: AppStrings.success.tr,
      message: AppStrings.successAddFlashCard.tr,
      type: SnackbarType.success,
    );
  }

  void editDeck(BuildContext context) {
    homeController.deckNameController.text =
        homeController.searchResults[deckIndex].name;
    homeController.deckDescriptionController.text =
        homeController.searchResults[deckIndex].desc;
    homeController.createBottomSheet(
      context: context,
      bottomSheetType: BottomSheetType.edit,
      index: deckIndex,
    );
  }

  void redirectToFlashCardPage(BuildContext context) {
    if (flashCards.isEmpty) {
      CustomSnackbar(
        title: AppStrings.error.tr,
        message: AppStrings.noFlashCard.tr,
        type: SnackbarType.error,
        onTap: (p0) => addFlashCard(context),
      );
      return;
    }
    Get.toNamed(
      Routes.FLASHCARDPAGE,
      arguments: [flashCards],
    );
  }
}

class _CustomFlashCardSide extends StatelessWidget {
  const _CustomFlashCardSide({
    required this.cardKey,
    required this.isLoading,
    required this.focusNode,
    required this.textEditingController,
    required this.label,
    required this.hintText,
    required this.btnText,
    required this.onTap,
    required this.submit,
  });

  final GlobalKey<FlipCardState> cardKey;
  final RxBool isLoading;
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final String label;
  final String hintText;
  final String btnText;
  final void Function() onTap;
  final void Function(String) submit;

  @override
  Widget build(BuildContext context) {
    final DeckDetailController deckDetailController = Get.find();
    return CustomFlashCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: CustomInputLabel(label: label)),
              Tooltip(
                message: AppStrings.csvTooltip.tr,
                child: Bounceable(
                  onTap: () => deckDetailController.addCardFromCsv(),
                  child: Icon(
                    Icons.upload_file_outlined,
                    color: AppColors.black,
                  ),
                ),
              ),
              Text(
                ".csv",
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.black,
                    ),
              ),
            ],
          ),
          AppSpacer.h1,
          Obx(
            () => CustomModalBottomSheetTextFormField(
              autoFocus: true,
              actionType: cardKey.currentState!.isFront
                  ? TextInputAction.next
                  : TextInputAction.done,
              submit: isLoading.value
                  ? null
                  : (p0) {
                      if (cardKey.currentState!.isFront) {
                        cardKey.currentState?.toggleCard();
                      } else {
                        isLoading.toggle();
                        submit(p0);
                      }
                      return null;
                    },
              onTapOutside: (p0) => focusNode.unfocus(),
              hintText: hintText,
              focusNode: focusNode,
              controller: textEditingController,
            ),
          ),
          AppSpacer.h3,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                onTap: () => cardKey.currentState?.toggleCard(),
                text: btnText,
                bg: AppColors.primary,
                textColor: AppColors.white,
              ),
              Obx(
                () => CustomButton(
                  isLoading: isLoading,
                  onTap: isLoading.value
                      ? null
                      : () {
                          isLoading.toggle();
                          onTap();
                        },
                  text: AppStrings.ok.tr,
                  bg: AppColors.primary,
                  textColor: AppColors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
