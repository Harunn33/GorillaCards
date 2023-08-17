import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorillacards/data/model/CreateDeckModel.dart';
import 'package:gorillacards/data/network/api/CreateDeckApi.dart';
import 'package:gorillacards/models/deckModel.dart';
import 'package:gorillacards/models/flashCardModel.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/methods/CustomLoadingDialog.dart';
import 'package:gorillacards/shared/methods/CustomSnackbar.dart';
import 'package:sizer/sizer.dart';

import '../../shared/constants/colors.dart';
import '../../shared/constants/paddings.dart';
import '../../shared/constants/spacer.dart';
import '../../shared/widgets/CustomButton.dart';
import '../../shared/widgets/CustomModalBottomSheetTextFormField.dart';
import '../Signin/SigninController.dart';

class HomeController extends GetxController {
  final CreateDeckApi _createDeckApi = CreateDeckApi();

  FocusNode deckNameFocusNode = FocusNode();
  FocusNode deckDescriptionFocuNode = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final SigninController signinController = SigninController();

  TextEditingController deckNameController = TextEditingController();
  TextEditingController deckDescriptionController = TextEditingController();

  RxBool buttonDisabled = false.obs;

// ALL INPUT UNFOCUS
  void allFocusNodeUnfocus() {
    deckNameFocusNode.unfocus();
    deckDescriptionFocuNode.unfocus();
  }

  // ALL INPUT TEXT REMOVE
  void allRemoveText() {
    deckNameController.clear();
    deckDescriptionController.clear();
  }

  // CREATE DECK REQUEST
  void handleCreateDeck() async {
    buttonDisabled.value = true;
    await Get.closeCurrentSnackbar();
    CustomLoadingDialog();
    final CreateDeckModel createDeckModel = CreateDeckModel(
      name: deckNameController.text,
      description: deckDescriptionController.text,
    );
    try {
      final response = await _createDeckApi.postCreateDeck(
        data: createDeckModel.toJson(),
        token: "Bearer ${signinController.box.read("token").toString()}",
      );
      if (response.statusCode == 201) {
        buttonDisabled.value = false;
        Get.close(2);
        allRemoveText();
        CustomSnackbar(
            title: AppStrings.success,
            message: AppStrings.createdDeckSuccessMessage,
            type: true);
      }
    } catch (e) {
      buttonDisabled.value = false;
      Get.back();
      CustomSnackbar(
          title: AppStrings.success,
          message: AppStrings.createdDeckErrorMessage);
    }
  }

// CREATE A BOTTOM SHEET
  void createBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      showDragHandle: true,
      builder: (context) {
        return Container(
          padding: AppPaddings.generalPadding.copyWith(
            bottom: 4.h,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.deckName,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppColors.black,
                        ),
                  ),
                  AppSpacer.h1,
                  CustomModalBottomSheetTextFormField(
                    onTapOutside: (p0) {
                      allFocusNodeUnfocus();
                    },
                    hintText: AppStrings.deckNameHint,
                    focusNode: deckNameFocusNode,
                    controller: deckNameController,
                    validator: (value) {
                      if (value == null) {
                        return null;
                      }
                      if (value.isEmpty) {
                        return AppStrings.deckNameInvalid;
                      }
                      return null;
                    },
                  ),
                  AppSpacer.h3,
                  Text(
                    AppStrings.deckDescription,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppColors.black,
                        ),
                  ),
                  AppSpacer.h1,
                  CustomModalBottomSheetTextFormField(
                    hintText: "",
                    focusNode: deckDescriptionFocuNode,
                    controller: deckDescriptionController,
                    isDescription: true,
                  ),
                  AppSpacer.h3,
                  CustomButton(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        handleCreateDeck();
                      }
                    },
                    text: AppStrings.createDeckButtonTitle,
                    bg: AppColors.primary,
                    textColor: AppColors.white,
                    hasIcon: false,
                    isWide: true,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  RxList<Deck> allDecks = <Deck>[
    Deck(
      "First Deck",
      1,
      [
        FlashCard("Deneme a", "Deneme s"),
      ],
      1,
    ),
    Deck(
      "Second Deck",
      2,
      [
        FlashCard("Deneme 1", "Deneme 2"),
        FlashCard("Deneme 3", "Deneme 4"),
      ],
      2,
    ),
    Deck(
      "Third Deck",
      3,
      [
        FlashCard("Deneme 5", "Deneme 6"),
        FlashCard("Deneme 7", "Deneme 8"),
        FlashCard("Deneme 9", "Deneme 10")
      ],
      3,
    ),
  ].obs;
}
