// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gorillacards/models/languageModel.dart';
import 'package:gorillacards/shared/constants/langs.dart';

class LocalizationController extends GetxController implements GetxService {
  RxString lang = "".obs;
  final GetStorage storage;

  LocalizationController({required this.storage}) {
    loadCurrentLanguage();
  }
  @override
  void onInit() {
    super.onInit();
    lang.value = storage.read(AppLangs.languageCode) ??
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;
  }

  Locale _locale = Locale(
    AppLangs.languages[0].languageCode,
    AppLangs.languages[0].countryCode,
  );
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  List<LanguageModel> _languages = [];

  Locale get locale => _locale;

  List<LanguageModel> get languages => _languages;

  void loadCurrentLanguage() async {
    _locale = Locale(
      storage.read(AppLangs.languageCode) ??
          WidgetsBinding.instance.platformDispatcher.locale.languageCode,
      storage.read(AppLangs.countryCode) ??
          WidgetsBinding.instance.platformDispatcher.locale.countryCode,
    );

    for (var i = 0; i < AppLangs.languages.length; i++) {
      if (AppLangs.languages[i].languageCode == _locale.languageCode) {
        _selectedIndex = i;
        break;
      }
    }
    _languages = [];
    _languages.addAll(AppLangs.languages);
    update();
  }

  void setLanguage(Locale locale) {
    Get.updateLocale(locale);
    _locale = locale;
    saveLanguage(_locale);
    update();
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    update();
  }

  void saveLanguage(Locale locale) async {
    storage.write(
      AppLangs.languageCode,
      locale.languageCode,
    );
    storage.write(
      AppLangs.countryCode,
      locale.countryCode!,
    );
  }
}
