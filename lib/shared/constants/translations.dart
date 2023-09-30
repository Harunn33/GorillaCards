import 'package:get/get.dart';

class TranslateString extends Translations {
  final Map<String, Map<String, String>> languages;

  TranslateString({required this.languages});
  @override
  Map<String, Map<String, String>> get keys {
    return languages;
  }
}
