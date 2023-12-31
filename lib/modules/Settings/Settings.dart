// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorillacards/controllers/LocalizationController.dart';
import 'package:gorillacards/controllers/NetworkController.dart';
import 'package:gorillacards/modules/Settings/SettingsController.dart';
import 'package:gorillacards/shared/constants/fonts.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import 'package:gorillacards/shared/constants/spacer.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/widgets/CustomLanguageButton.dart';
import 'package:gorillacards/shared/widgets/CustomNoInternet.dart';
import '../../shared/widgets/CustomSettingsItem.dart';

class Settings extends GetView<SettingsController> {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final NetworkController networkController = Get.put(NetworkController());

    return GetBuilder<NetworkController>(
      builder: (builder) {
        if (networkController.connectionType.value == 0) {
          return const CustomNoInternet();
        }
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              AppStrings.settings.tr,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontFamily: AppFonts.medium,
                  ),
            ),
          ),
          body: GetBuilder<LocalizationController>(
              builder: (localizationController) {
            return Padding(
              padding: AppPaddings.generalPadding,
              child: Column(
                children: [
                  // AppSpacer.h3,
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Text(
                  //         "Kullanıcı Id: ${supabase.auth.currentUser!.id}",
                  //         style: Theme.of(context).textTheme.titleMedium,
                  //         overflow: TextOverflow.ellipsis,
                  //       ),
                  //     ),
                  //     Bounceable(
                  //       onTap: () {
                  //         Clipboard.setData(
                  //           ClipboardData(
                  //             text: supabase.auth.currentUser!.id,
                  //           ),
                  //         );
                  //       },
                  //       child: const Icon(
                  //         Icons.copy_outlined,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  AppSpacer.h3,
                  Row(
                    children: [
                      Expanded(
                        child: CustomLanguageButton(
                            languageModel: localizationController.languages[0],
                            localizationController: localizationController,
                            index: 0,
                            path: localizationController
                                .languages[0].languageCode),
                      ),
                      AppSpacer.w3,
                      Expanded(
                        child: CustomLanguageButton(
                            languageModel: localizationController.languages[1],
                            localizationController: localizationController,
                            index: 1,
                            path: localizationController
                                .languages[1].languageCode),
                      ),
                    ],
                  ),
                  AppSpacer.h3,
                  CustomSettingsItem(
                    icon: Icons.logout_outlined,
                    onTap: () {
                      controller.isLoading.toggle();
                      controller.handleSignOut();
                    },
                    title: AppStrings.signOut.tr,
                    isLoading: controller.isLoading,
                  ),

                  // AppSpacer.h1,
                  // CustomSettingsItem(
                  //   icon: Icons.delete_outline_outlined,
                  //   onTap: () {},
                  //   title: AppStrings.deleteAccount.tr,
                  //   color: AppColors.red,
                  //   textColor: AppColors.white,
                  //   icColor: AppColors.white,
                  // ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
