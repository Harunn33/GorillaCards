// ignore_for_file: file_names

class ApiUrl {
  ApiUrl._();
  // base url
  static const String baseUrl = "https://stg-api.gorillacards.app/";

  // receiveTimeout
  static const Duration receiveTimeout = Duration(milliseconds: 15000);

  // connectTimeout
  static const Duration connectionTimeout = Duration(milliseconds: 15000);

  static const String signupPath = '/auth/signup';
  static const String signinPath = '/auth/signin';
  static const String createDeckPath = '/decks';
}
