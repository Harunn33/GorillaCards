import 'package:flutter/material.dart';
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
                Text(
                  AppStrings.deckName,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.black,
                      ),
                ),
                AppSpacer.h1,
                CustomModalBottomSheetTextFormField(
                  onTapOutside: onTapOutside,
                  actionType: TextInputAction.next,
                  hintText: AppStrings.deckNameHint,
                  focusNode: deckNameFocusNode,
                  controller: deckNameController,
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
                Text(
                  AppStrings.deckDescription,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.black,
                      ),
                ),
                AppSpacer.h1,
                CustomModalBottomSheetTextFormField(
                  actionType: TextInputAction.done,
                  hintText: "",
                  focusNode: deckDescriptionFocuNode,
                  controller: deckDescriptionController,
                  isDescription: true,
                ),
                AppSpacer.h3,
                CustomButton(
                  onTap: onTap,
                  text: AppStrings.createDeckButtonTitle,
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
