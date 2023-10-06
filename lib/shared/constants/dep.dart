// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_collection_literals

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gorillacards/controllers/LocalizationController.dart';
import 'package:gorillacards/models/languageModel.dart';
import 'package:gorillacards/shared/constants/langs.dart';

Future<Map<String, Map<String, String>>> init() async {
  final storage = GetStorage();
  Get.lazyPut(() => storage);
  Get.lazyPut(
    () => LocalizationController(
      storage: Get.find(),
    ),
  );

  Map<String, Map<String, String>> _languages = Map();
  for (LanguageModel languageModel in AppLangs.languages) {
    String jsonStringValues = await rootBundle
        .loadString("assets/langs/${languageModel.languageCode}.json");
    Map<String, dynamic> _mappedJson = json.decode(jsonStringValues);
    Map<String, String> _json = Map();

    _mappedJson.forEach((key, value) {
      _json[key] = value.toString();
    });

    _languages["${languageModel.languageCode}_${languageModel.countryCode}"] =
        _json;
  }
  return _languages;
}
