// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorillacards/modules/Settings/SettingsController.dart';
import 'package:gorillacards/shared/constants/colors.dart';
import 'package:gorillacards/shared/constants/fonts.dart';
import 'package:gorillacards/shared/constants/paddings.dart';
import 'package:gorillacards/shared/constants/spacer.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../di.dart';
import '../../routes/app_pages.dart';
import '../../shared/methods/CustomLoadingDialog.dart';
import '../../shared/methods/CustomSnackbar.dart';
import '../../shared/widgets/CustomSettingsItem.dart';

class Settings extends GetView<SettingsController> {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppStrings.settings,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontFamily: AppFonts.medium,
              ),
        ),
      ),
      body: Padding(
        padding: AppPaddings.generalPadding,
        child: Column(
          children: [
            AppSpacer.h3,
            const CustomSettingsItem(
              icon: Icons.logout_outlined,
              onTap: handleSignOut,
              title: AppStrings.signOut,
            ),
            AppSpacer.h1,
            CustomSettingsItem(
              icon: Icons.delete_outline_outlined,
              onTap: () {},
              title: AppStrings.deleteAccount,
              color: AppColors.red,
              textColor: AppColors.white,
              icColor: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> handleSignOut() async {
  try {
    await Get.closeCurrentSnackbar();
    CustomLoadingDialog();
    await supabase.auth.signOut();
    Get.offAllNamed(Routes.WELCOME);
  } on AuthException catch (error) {
    Get.back();
    CustomSnackbar(
      title: AppStrings.error,
      message: error.message,
    );
  }
}
