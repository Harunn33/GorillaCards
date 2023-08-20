// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:gorillacards/shared/constants/apiUrl.dart';
import '../services/ApiService.dart';

class SigninApi {
  final ApiService _apiService = ApiService();

  Future<Response> putSignin({Map<String, dynamic>? data}) async {
    try {
      final Response response = await _apiService.put(
        ApiUrl.signinPath,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}