import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:kitobzor_app/core/network/dio_client.dart';
import 'package:kitobzor_app/core/network/token_storage.dart';
import 'package:kitobzor_app/injection_container.dart';

class AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSource(this.dioClient);

  Future<Map<String, dynamic>> login(String phoneNumber, int otpCode) async {
    try {
      final response = await dioClient.dio.post(
        'auth/login/', // Base URL bilan birga ishlaydi
        data: {"otp_code": otpCode, "phone_number": phoneNumber},
      );
      // log('Login response: ${response.data}');
      return response.data
          as Map<String, dynamic>; // {accessToken, refreshToken}
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Login failed');
    }
  }

  Future<void> logout() async {
    try {
      // clean tokens with TokenStorage
      // sl<TokenStorage>().clearTokens();
      log('Tokens: ${sl<TokenStorage>().getAccessToken()}, ${sl<TokenStorage>().getRefreshToken()}');
      log('Logout successful');
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Logout failed');
    }
  }
}
