// ignore_for_file: constant_identifier_names

import 'package:get/route_manager.dart';
import 'package:gorillacards/modules/FlashCardPage/FlashCardPage.dart';
import 'package:gorillacards/modules/FlashCardPage/FlashCardPageBinding.dart';
import 'package:gorillacards/modules/Home/Home.dart';
import 'package:gorillacards/modules/Home/HomeBinding.dart';
import 'package:gorillacards/modules/Signin/Signin.dart';
import 'package:gorillacards/modules/Signin/SigninBinding.dart';
import 'package:gorillacards/modules/Signup/Signup.dart';
import 'package:gorillacards/modules/Signup/SignupBinding.dart';

import '../modules/Splash/index.dart';
import '../modules/Welcome/index.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const Splash(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.WELCOME,
      page: () => const Welcome(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: Routes.SIGNUP,
      page: () => const Signup(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: Routes.SIGNIN,
      page: () => Signin(),
      binding: SigninBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const Home(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.FLASHCARDPAGE,
      page: () => const FlashCardPage(),
      binding: FlashCardPageBinding(),
    ),
  ];
}
