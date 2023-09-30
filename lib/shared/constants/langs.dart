// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:gorillacards/models/languageModel.dart';

class AppLangs {
  AppLangs._();

  static const EN_LOCALE = Locale("en", "US");
  static const countryCode = "country_code";
  static const languageCode = "language_code";
  static const lang_path = "assets/langs/";

  static List<LanguageModel> languages = [
    LanguageModel(
      languageName: "English",
      languageCode: "en",
      countryCode: "US",
    ),
    LanguageModel(
      languageName: "Turkish",
      languageCode: "tr",
      countryCode: "TR",
    ),
  ];
}
