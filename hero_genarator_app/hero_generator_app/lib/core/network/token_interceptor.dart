import 'dart:developer';

import 'package:dio/dio.dart';
import 'token_storage.dart';

class TokenInterceptor extends Interceptor {
  final TokenStorage tokenStorage;

  const TokenInterceptor(this.tokenStorage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await tokenStorage.getAccessToken();
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // log('Unauthorized request, trying to refresh token');
      final refreshToken = await tokenStorage.getRefreshToken();
      // log( 'Refresh token: $refreshToken');

      if (refreshToken != null) {
        try {
          final dio = Dio();
          final response = await dio.post(
            'https://api.kitobzor.uz/api/v1/auth/refresh/',
            data: {'refresh_token': refreshToken},
          );

          final newAccessToken = response.data['access_token'];
          final newRefreshToken = response.data['refresh_token'];

          log('New tokens received: $newAccessToken, $newRefreshToken');
          // await tokenStorage.clearTokens();
          await tokenStorage.saveTokens(accessToken: newAccessToken, refreshToken: newRefreshToken);

          err.requestOptions.headers['Authorization'] =
              'Bearer $newAccessToken';
          final retryResponse = await dio.fetch(err.requestOptions);
          return handler.resolve(retryResponse);
        } catch (_) {
          return handler.next(err);
        }
      }
    }
    return handler.next(err);
  }
}
