import 'package:sport_app/model/user.dart';

class UserResponse {
  User? data;
  String? message;

  UserResponse({this.data, this.message});

  UserResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? User.fromJson(json['data']) : null;
    message = json['message'];
  }
}
