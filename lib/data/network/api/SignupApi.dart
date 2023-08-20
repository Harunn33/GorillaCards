// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import '../services/ApiService.dart';

class SignupApi {
  final ApiService _apiService = ApiService();

  Future<Response> postSignup({Map<String, dynamic>? data}) async {
    try {
      final Response response = await _apiService.post(
        AppStrings.signupPath,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
