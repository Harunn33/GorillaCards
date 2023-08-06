import 'package:get/get.dart';
import 'package:gorillacards/shared/constants/strings.dart';

import '../constants/colors.dart';

SnackbarController CustomSnackbar() {
  return Get.snackbar(
    AppStrings.error,
    AppStrings.invalidEmailOrPassword,
    backgroundColor: AppColors.red,
    colorText: AppColors.white,
  );
}
