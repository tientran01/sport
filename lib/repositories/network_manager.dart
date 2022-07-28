import 'package:dio/dio.dart';

class NetWorkManager {
  static NetWorkManager shared = NetWorkManager._internal();
  NetWorkManager._internal();

  String baseUrl = 'https://api.mediastack.com/v1';
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> get(
    String url,
    Map<String, dynamic> param,
  ) async {
    Response response = await _dio.get("$baseUrl/$url", queryParameters: param);

    return response.data;
  }


}
