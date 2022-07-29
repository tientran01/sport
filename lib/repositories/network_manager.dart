import 'package:dio/dio.dart';
import 'package:sport_app/application/application.dart';

class NetWorkManager {
  static NetWorkManager shared = NetWorkManager._internal();
  NetWorkManager._internal();

  final Dio _dio = Dio();

  Future<Map<String, dynamic>> get(
    String url,
    Map<String, dynamic>? param,
  ) async {
    Response response = await _dio.get(
      '${Application.baseUrl}$url',
      queryParameters: param,
    );
    return response.data;
  }
}
