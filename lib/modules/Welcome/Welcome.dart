// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorillacards/routes/app_pages.dart';
import 'package:gorillacards/shared/constants/colors.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import 'package:gorillacards/shared/constants/spacer.dart';
import 'package:gorillacards/shared/constants/strings.dart';

import '../../shared/widgets/CustomButton.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: Padding(
            padding: AppPaddings.generalPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.welcomeTitle.trParams({
                    "appName": AppStrings.appName,
                  }),
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                AppSpacer.h1,
                Text(
                  AppStrings.welcomeDescription.trParams({
                    "appName": AppStrings.appName,
                  }),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                AppSpacer.h1,
                Text(
                  AppStrings.welcomeDescription2.tr,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                AppSpacer.h3,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      bg: AppColors.primary,
                      onTap: () {
                        Get.toNamed(Routes.SIGNIN);
                      },
                      text: AppStrings.signin.tr,
                      textColor: AppColors.white,
                    ),
                    CustomButton(
                      bg: AppColors.dreamyCloud,
                      onTap: () {
                        Get.toNamed(Routes.SIGNUP);
                      },
                      text: AppStrings.signup.tr,
                      textColor: AppColors.black,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
