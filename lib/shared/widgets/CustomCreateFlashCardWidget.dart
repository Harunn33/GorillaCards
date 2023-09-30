import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:gorillacards/shared/methods/CustomSnackbar.dart';

import '../../di.dart';
import '../../models/deckModel.dart';
import '../../modules/Home/HomeController.dart';
import '../constants/colors.dart';
import '../constants/spacer.dart';
import '../constants/strings.dart';
import 'CustomButton.dart';
import 'CustomFlashCard.dart';
import 'CustomInputLabel.dart';
import 'CustomModalBottomSheetTextFormField.dart';

class CustomCreateFlashCard extends StatelessWidget {
  const CustomCreateFlashCard({
    super.key,
    required this.focusNode,
    required this.controller,
    required this.cardKey,
    required this.label,
    required this.btnText,
    required this.hint,
    required this.onTapOutside,
    required this.homeController,
    required this.index,
    required this.uid,
  });

  final FocusNode focusNode;
  final TextEditingController controller;
  final GlobalKey<FlipCardState> cardKey;
  final String label;
  final String btnText;
  final String hint;
  final void Function(PointerDownEvent)? onTapOutside;
  final HomeController homeController;
  final int index;
  final String? uid;

  @override
  Widget build(BuildContext context) {
    RxBool isLoading = false.obs;
    return CustomFlashCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: CustomInputLabel(label: label)),
              Tooltip(
                message:
                    "You can upload a csv file with headers named 'id, back, front'",
                child: Bounceable(
                  onTap: () => addCardFromCsvFile(homeController, index, uid),
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
                        _addCard(homeController, index, uid, isLoading);
                      }
                      return null;
                    },
              onTapOutside: onTapOutside,
              hintText: hint,
              focusNode: focusNode,
              controller: controller,
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
                          _addCard(homeController, index, uid, isLoading);
                        },
                  text: AppStrings.ok,
                  bg: AppColors.primary,
                  textColor: AppColors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

Future<void> addCardFromCsvFile(
    HomeController homeController, int index, String? uid) async {
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
      final Content flashCard = Content(
          id: homeController.allDecks[index].content.length + 1,
          back: rowData["back"],
          front: rowData["front"]);
      List<dynamic> list = await supabase
          .from("decks")
          .select("content")
          .eq("uid", uid)
          .eq("id", homeController.searchResults[index].id);
      list[0]["content"].add(flashCard.toJson());
      await supabase
          .from("decks")
          .update(list[0])
          .eq("uid", uid)
          .eq("id", homeController.searchResults[index].id);
      homeController.allDecks[index].content.add(flashCard);
      convertedData.add(rowData);
    } catch (e) {
      CustomSnackbar(
        title: AppStrings.error,
        message: e.toString(),
        type: SnackbarType.error,
      );
    }
  }
  Get.back();
  CustomSnackbar(
    title: AppStrings.success,
    message: AppStrings.successAddFlashCard,
    type: SnackbarType.success,
  );
}

Future<void> _addCard(HomeController homeController, int index, String? uid,
    RxBool? isLoading) async {
  if (homeController.frontCardController.text.isNotEmpty ||
      homeController.backCardController.text.isNotEmpty) {
    final Content flashCard = Content(
      id: homeController.allDecks[index].content.length + 1,
      front: homeController.frontCardController.text,
      back: homeController.backCardController.text,
    );
    try {
      List<dynamic> list = await supabase
          .from("decks")
          .select("content")
          .eq("uid", uid)
          .eq("id", homeController.searchResults[index].id);
      list[0]["content"].add(flashCard.toJson());
      await supabase
          .from("decks")
          .update(list[0])
          .eq("uid", uid)
          .eq("id", homeController.searchResults[index].id);
      homeController.allDecks[index].content.add(flashCard);
      Get.back();
      CustomSnackbar(
        title: AppStrings.success,
        message: AppStrings.successAddFlashCard,
        type: SnackbarType.success,
      );
    } catch (e) {
      isLoading?.toggle();
      CustomSnackbar(
        title: AppStrings.error,
        message: e.toString(),
        type: SnackbarType.error,
      );
    }
  }
  isLoading?.toggle();
}
