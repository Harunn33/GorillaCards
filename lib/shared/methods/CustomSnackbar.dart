import 'package:get/get.dart';

import '../constants/colors.dart';

SnackbarController CustomSnackbar(
    {required String title, required String message, bool type = false}) {
  return Get.snackbar(
    title,
    message,
    backgroundColor: type ? AppColors.dustyGreen : AppColors.red,
    colorText: AppColors.white,
  );
}
