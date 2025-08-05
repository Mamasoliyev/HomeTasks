import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:kitobzor_app/core/network/token_interceptor.dart';
import 'package:kitobzor_app/core/network/token_storage.dart';
import 'package:kitobzor_app/injection_container.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  final Dio dio;

  DioClient(String baseUrl) : dio = Dio(BaseOptions(baseUrl: baseUrl)) {
    log('DioClient initialized with base URL: $baseUrl');
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        compact: false,
        maxWidth: 90,
      ),
    );
    dio.interceptors.add(TokenInterceptor(sl<TokenStorage>()));
  }
}
