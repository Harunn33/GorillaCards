// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:gorillacards/shared/constants/apiUrl.dart';
import '../services/ApiService.dart';

class CreateDeckApi {
  final ApiService _apiService = ApiService();

  Future<Response> postCreateDeck(
      {Map<String, dynamic>? data, required String token}) async {
    try {
      final Response response = await _apiService.post(ApiUrl.createDeckPath,
          data: data,
          options: Options(
            headers: {
              "Authorization": token,
            },
          ));
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
