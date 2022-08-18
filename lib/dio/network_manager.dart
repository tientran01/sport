import 'dart:async';
import 'package:dio/dio.dart';
import 'package:sport_app/dio/dio_exception_handle.dart';
import 'package:sport_app/dio/end_point.dart';
import 'package:sport_app/model/base_model.dart';

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

  Future<dynamic> get(String path, Map<String, dynamic>? param) async {
    try {
      Response response = await _dio.get(path, queryParameters: param);
      return response.data;
    } on DioError catch (err) {
      final errorMsg = DioExceptionHandle.getDioError(err).toString();
      return BaseModel(data: null, error: errorMsg);
    }
  }
}
