
import 'package:dio/dio.dart';
import 'package:kitobzor_app/core/network/dio_client.dart';

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

  Future<void> updateProfile({
    required String firstName,
    required String lastName,
    required String phone,
  }) async {
    try {
      await dioClient.dio.patch(
        '/me/update/',
        data: {
          "first_name": firstName,
          "last_name": lastName,
          "app_phone_number": phone,
        },
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Update failed');
    }
  }
}
