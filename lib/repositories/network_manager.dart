import 'dart:async';

import 'package:dio/dio.dart';
import 'package:sport_app/application/application.dart';
import 'package:sport_app/helper/loading.dart';
import 'package:sport_app/resource/resource.dart';

class NetWorkManager {
  static NetWorkManager shared = NetWorkManager._internal();
  NetWorkManager._internal();
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Application.baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    ),
  );

  Future<dynamic> get(
    String url,
    Map<String, dynamic>? param,
  ) async {
    try {
      Response response = await _dio.get(url, queryParameters: param);
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      Loading.showError(AppStrings.error);
    }
  }
}
