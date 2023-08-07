import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:gorillacards/modules/Home/HomeController.dart';
import 'package:gorillacards/shared/constants/colors.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import 'package:gorillacards/shared/constants/spacer.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/enums/images.dart';
import 'package:gorillacards/shared/widgets/CustomButton.dart';
import 'package:gorillacards/shared/widgets/CustomModalBottomSheetTextFormField.dart';
import 'package:sizer/sizer.dart';

import '../../routes/app_pages.dart';

class Home extends GetView<HomeController> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: double.infinity,
        leading: Padding(
          padding: AppPaddings.generalPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Images.appLogo.png,
              Bounceable(
                onTap: () {
                  controller.signinController.box.remove("token");
                  Get.offAllNamed(Routes.WELCOME);
                },
                child: Images.settings.svg,
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: AppPaddings.generalPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  AppStrings.noDecksYet,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => CustomButton(
                        onTap: controller.buttonDisabled.value
                            ? null
                            : () {
                                controller.allRemoveText();
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: AppColors.white,
                                  showDragHandle: true,
                                  builder: (context) {
                                    return GestureDetector(
                                      onTap: () {
                                        controller.allFocusNodeUnfocus();
                                      },
                                      child: Container(
                                        padding:
                                            AppPaddings.generalPadding.copyWith(
                                          bottom: 4.h,
                                        ),
                                        child: SingleChildScrollView(
                                          child: Form(
                                            key: controller.formKey,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  AppStrings.deckName,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium
                                                      ?.copyWith(
                                                        color: AppColors.black,
                                                      ),
                                                ),
                                                AppSpacer.h1,
                                                CustomModalBottomSheetTextFormField(
                                                  hintText:
                                                      AppStrings.deckNameHint,
                                                  focusNode: controller
                                                      .deckNameFocusNode,
                                                  controller: controller
                                                      .deckNameController,
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return null;
                                                    }
                                                    if (value.isEmpty) {
                                                      return AppStrings
                                                          .deckNameInvalid;
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                AppSpacer.h3,
                                                Text(
                                                  AppStrings.deckDescription,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium
                                                      ?.copyWith(
                                                        color: AppColors.black,
                                                      ),
                                                ),
                                                AppSpacer.h1,
                                                CustomModalBottomSheetTextFormField(
                                                  hintText: "",
                                                  focusNode: controller
                                                      .deckDescriptionFocuNode,
                                                  controller: controller
                                                      .deckDescriptionController,
                                                  isDescription: true,
                                                ),
                                                AppSpacer.h3,
                                                CustomButton(
                                                  onTap: () {
                                                    if (controller
                                                        .formKey.currentState!
                                                        .validate()) {
                                                      controller
                                                          .handleCreateDeck();
                                                    }
                                                  },
                                                  text: AppStrings
                                                      .createDeckButtonTitle,
                                                  bg: AppColors.primary,
                                                  textColor: AppColors.white,
                                                  hasIcon: false,
                                                  isWide: true,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                                // controller.handleCreateDeck();
                              },
                        text: "Add Deck",
                        bg: AppColors.primary,
                        textColor: AppColors.white,
                        hasIcon: true,
                      ),
                    ),
                  ),
                  AppSpacer.w3,
                  Expanded(
                    child: CustomButton(
                      onTap: () {},
                      text: "Browse Decks",
                      icon: Icons.search,
                      bg: AppColors.primary,
                      textColor: AppColors.white,
                      hasIcon: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
