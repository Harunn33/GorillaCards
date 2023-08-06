import 'package:dio/dio.dart';
import 'package:gorillacards/shared/constants/strings.dart';
import '../services/ApiService.dart';

class SigninApi {
  final ApiService _apiService = ApiService();

  Future<Response> putSignin({Map<String, dynamic>? data}) async {
    try {
      final Response response = await _apiService.put(
        AppStrings.signinPath,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
