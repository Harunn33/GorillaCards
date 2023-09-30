import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gorillacards/controllers/localizationController.dart';
import 'package:gorillacards/di.dart';
import 'package:gorillacards/routes/app_pages.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/constants/theme.dart';
import 'package:gorillacards/shared/constants/translations.dart';
import 'package:sizer/sizer.dart';
import 'package:gorillacards/shared/constants/dep.dart' as dep;

void main() async {
  await AppInit.init();
  Map<String, Map<String, String>> languages = await dep.init();
  runApp(MyApp(
    languages: languages,
  ));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  const MyApp({super.key, required this.languages});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
      builder: (localizationController) {
        return Sizer(
          builder: (context, orientation, deviceType) {
            return GetMaterialApp(
              title: AppStrings.appName,
              theme: CustomTheme(),
              debugShowCheckedModeBanner: false,
              initialRoute: AppPages.INITIAL,
              getPages: AppPages.routes,
              translations: TranslateString(languages: languages),
              locale: localizationController.locale,
              fallbackLocale: Locale(
                WidgetsBinding.instance.platformDispatcher.locale.languageCode,
                WidgetsBinding.instance.platformDispatcher.locale.countryCode,
              ),
            );
          },
        );
      },
    );
  }
}
