import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:gorillacards/di.dart';
import 'package:gorillacards/routes/app_pages.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import 'package:gorillacards/shared/constants/theme.dart';
import 'package:sizer/sizer.dart';

void main() async {
  AppInit.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        title: AppStrings.appName,
        theme: CustomTheme(),
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      );
    });
  }
}
