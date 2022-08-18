import 'dart:async';
import 'package:dio/dio.dart';
import 'package:sport_app/dio/end_point.dart';
import 'package:sport_app/helper/loading.dart';
import 'package:sport_app/resource/resource.dart';

class NetWorkManager {
  static NetWorkManager shared = NetWorkManager._internal();
  NetWorkManager._internal();
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: EndPoint.baseUrl,
      connectTimeout: EndPoint.connectionTimeout,
      receiveTimeout: EndPoint.receiveTimeout,
      headers: {'Content-Type': 'EndPoint/json; charset=UTF-8'},
    ),
  );

  Future<dynamic> get(
    String path,
    Map<String, dynamic>? param,
  ) async {
    try {
      Response response = await _dio.get(path, queryParameters: param);
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      Loading.showError(AppStrings.error);
    }
  }
}
