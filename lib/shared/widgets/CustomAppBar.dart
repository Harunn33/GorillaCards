// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:gorillacards/routes/app_pages.dart';
import 'package:gorillacards/shared/methods/CustomLoadingDialog.dart';
import 'package:sizer/sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../di.dart';
import '../constants/paddings.dart';
import '../constants/strings.dart';
import '../enums/images.dart';
import '../methods/CustomSnackbar.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: double.infinity,
      leading: Padding(
        padding: AppPaddings.generalPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Images.appLogo.png,
            Bounceable(
              onTap: () async {
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
              },
              child: Images.settings.svg,
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(6.h);
}
