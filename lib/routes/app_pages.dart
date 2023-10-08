// ignore_for_file: constant_identifier_names

import 'package:get/route_manager.dart';
import 'package:gorillacards/modules/Curriculum/Curriculum.dart';
import 'package:gorillacards/modules/Curriculum/CurriculumBinding.dart';
import 'package:gorillacards/modules/CurriculumTestPage/CurriculumTestPage.dart';
import 'package:gorillacards/modules/CurriculumTestPage/CurriculumTestPageBinding.dart';
import 'package:gorillacards/modules/DeckDetail/DeckDetail.dart';
import 'package:gorillacards/modules/DeckDetail/DeckDetailBinding.dart';
import 'package:gorillacards/modules/FlashCardPage/FlashCardPage.dart';
import 'package:gorillacards/modules/FlashCardPage/FlashCardPageBinding.dart';
import 'package:gorillacards/modules/Home/Home.dart';
import 'package:gorillacards/modules/Home/HomeBinding.dart';
import 'package:gorillacards/modules/ReadyDeck/ReadyDeck.dart';
import 'package:gorillacards/modules/ReadyDeck/ReadyDeckBinding.dart';
import 'package:gorillacards/modules/ReadyDeckViewer/ReadyDeckViewer.dart';
import 'package:gorillacards/modules/ReadyDeckViewer/ReadyDeckViewerBinding.dart';
import 'package:gorillacards/modules/Result/Result.dart';
import 'package:gorillacards/modules/Result/ResultBinding.dart';
import 'package:gorillacards/modules/Settings/Settings.dart';
import 'package:gorillacards/modules/Settings/SettingsBinding.dart';
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
    GetPage(
      name: Routes.SETTINGS,
      page: () => const Settings(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: Routes.RESULT,
      page: () => const Result(),
      binding: ResultBinding(),
    ),
    GetPage(
      name: Routes.DECKDETAIL,
      page: () => const DeckDetail(),
      binding: DeckDetailBinding(),
    ),
    GetPage(
      name: Routes.READYDECK,
      page: () => const ReadyDeck(),
      binding: ReadyDeckBinding(),
    ),
    GetPage(
      name: Routes.READYDECKVIEWER,
      page: () => const ReadyDeckViewer(),
      binding: ReadyDeckViewerBinding(),
    ),
    GetPage(
      name: Routes.CURRICULUM,
      page: () => const Curriculum(),
      binding: CurriculumBinding(),
    ),
    GetPage(
      name: Routes.CURRICULUMTESTPAGE,
      page: () => const CurriculumTestPage(),
      binding: CurriculumTestPageBinding(),
    ),
  ];
}
