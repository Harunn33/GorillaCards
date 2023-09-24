// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:gorillacards/shared/widgets/CustomInputLabel.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';
import '../constants/paddings.dart';
import '../constants/spacer.dart';
import '../constants/strings.dart';
import '../widgets/CustomButton.dart';
import '../widgets/CustomModalBottomSheetTextFormField.dart';

Future<dynamic> CustomModalBottomSheet({
  required BuildContext context,
  required GlobalKey<FormState> formKey,
  required void Function(PointerDownEvent)? onTapOutside,
  required FocusNode deckNameFocusNode,
  required FocusNode deckDescriptionFocuNode,
  required TextEditingController deckNameController,
  required TextEditingController deckDescriptionController,
  required void Function() onTap,
  required String? Function(String)? submit,
  bool isEditButton = false,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.white,
    showDragHandle: true,
    builder: (context) {
      return Container(
        padding: AppPaddings.generalPadding.copyWith(
          bottom: MediaQuery.of(context).viewInsets.bottom +
              4.h, // https://stackoverflow.com/questions/53869078/how-to-move-bottomsheet-along-with-keyboard-which-has-textfieldautofocused-is-t
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomInputLabel(label: AppStrings.deckName),
                AppSpacer.h1,
                CustomModalBottomSheetTextFormField(
                  onTapOutside: onTapOutside,
                  actionType: TextInputAction.next,
                  hintText: AppStrings.deckNameHint,
                  focusNode: deckNameFocusNode,
                  controller: deckNameController,
                  autoFocus: true,
                  validator: (value) {
                    if (value == null) {
                      return null;
                    }
                    if (value.isEmpty) {
                      return "* ${AppStrings.deckNameInvalid}";
                    }
                    return null;
                  },
                ),
                AppSpacer.h3,
                const CustomInputLabel(
                  label: AppStrings.deckDescription,
                ),
                AppSpacer.h1,
                CustomModalBottomSheetTextFormField(
                  actionType: TextInputAction.done,
                  hintText: "",
                  focusNode: deckDescriptionFocuNode,
                  controller: deckDescriptionController,
                  isDescription: true,
                  submit: submit,
                ),
                AppSpacer.h3,
                CustomButton(
                  onTap: onTap,
                  text: isEditButton
                      ? AppStrings.editDeckButtonTitle
                      : AppStrings.createDeckButtonTitle,
                  bg: AppColors.primary,
                  textColor: AppColors.white,
                  hasIcon: false,
                  isWide: true,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
