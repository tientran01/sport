import 'package:sport_app/application/application.dart';
import 'package:sport_app/model/news.dart';
import 'package:sport_app/repositories/network_manager.dart';

class ApiClient {
  static final ApiClient api = ApiClient._internal();
  ApiClient._internal();

  Future<News> getNews() async {
    Map<String, dynamic> param = {
      'access_key': Application.accessKey,
    };
    Map<String, dynamic> a = await NetWorkManager.shared.get('news', {
      'access_key': Application.accessKey,
    });
    return News.fromJson(a);
  }
}
