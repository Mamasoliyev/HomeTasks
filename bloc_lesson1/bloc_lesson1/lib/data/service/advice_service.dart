import 'dart:convert';
import 'dart:developer';

import 'package:bloc_lesson1/data/models/advice_model.dart';
import 'package:dio/dio.dart';
import 'dart:io';
class AdviceService {
  static Future<AdviceModel> fetchData() async {
    Dio dio = Dio();
    final response = await dio.get(
      'https://api.adviceslip.com/advice',
      options: Options(headers: {'Content-Type': 'application/json'}),
    );
    log(response.data.toString());
    
    final data = jsonDecode(response.data);
    final Map<String, dynamic> data1 = data["slip"];
    log("chiki");

    final advice = AdviceModel.fromMap(data1);
    return advice; // List qaytaryapmiz, lekin bitta element bor
  }
}


