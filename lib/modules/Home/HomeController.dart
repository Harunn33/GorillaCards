import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorillacards/data/model/CreateDeckModel.dart';
import 'package:gorillacards/data/network/api/CreateDeckApi.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/methods/CustomLoadingDialog.dart';
import 'package:gorillacards/shared/methods/CustomSnackbar.dart';

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

  void allFocusNodeUnfocus() {
    deckNameFocusNode.unfocus();
    deckDescriptionFocuNode.unfocus();
  }

  void allRemoveText() {
    deckNameController.clear();
    deckDescriptionController.clear();
  }

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
}
