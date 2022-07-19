// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:sport_app/application/application.dart';
import 'package:sport_app/model/data.dart';
import 'package:sport_app/model/user_response.dart';
import 'package:dio/dio.dart';

class ApiClient {
  static final ApiClient api = ApiClient._internal();

  ApiClient._internal();

  final Dio _dio = Dio();
  String baseUrl = Application.baseUrl;
  String getDataUrl = Application.getDataUrl;
  Future<UserResponse> login(String? username, String? password) async {
    Response response =
        await _dio.post(baseUrl + "/api/v1/sign_in", queryParameters: {
      'user_name': username,
      'password': password,
    });
    return UserResponse.fromJson(response.data);
  }

  Future<GetData> getDataById(int id) async {
    Response response = await _dio.get(getDataUrl + "/posts?id=$id");
    GetData datas = GetData.fromJson(response.data);
    return datas;
  }

  Future<GetData> getDataByUserId(int userId) async {
    Response response = await _dio.get(getDataUrl + "/posts?userId=$userId");
    GetData datas = GetData.fromJson(response.data);
    return datas;
  }
}
