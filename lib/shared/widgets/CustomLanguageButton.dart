// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:gorillacards/controllers/LocalizationController.dart';
import 'package:gorillacards/models/languageModel.dart';
import 'package:gorillacards/shared/constants/borderRadius.dart';
import 'package:gorillacards/shared/constants/colors.dart';
import 'package:gorillacards/shared/constants/fonts.dart';
import 'package:gorillacards/shared/constants/langs.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import 'package:sizer/sizer.dart';

class CustomLanguageButton extends StatelessWidget {
  final LanguageModel languageModel;
  final LocalizationController localizationController;
  final int index;
  final String path;
  const CustomLanguageButton(
      {super.key,
      required this.languageModel,
      required this.localizationController,
      required this.index,
      required this.path});

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () async {
        localizationController.setLanguage(
          Locale(
            AppLangs.languages[index].languageCode,
            AppLangs.languages[index].countryCode,
          ),
        );
        localizationController.setSelectedIndex(index);
        localizationController.lang.value =
            AppLangs.languages[index].languageCode;
      },
      child: Container(
        padding: AppPaddings.h3v1Padding,
        decoration: BoxDecoration(
          borderRadius: AppBorderRadius.generalRadius,
          border: Border.all(
            width: .4.w,
            color: AppColors.dreamyCloud,
          ),
          color: localizationController.selectedIndex == index
              ? AppColors.primary
              : AppColors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: Image.asset(
                "assets/images/$path.png",
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                languageModel.languageName,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: AppFonts.medium,
                      color: localizationController.selectedIndex != index
                          ? AppColors.black
                          : AppColors.white,
                    ),
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
