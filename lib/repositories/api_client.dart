import 'package:sport_app/application/application.dart';
import 'package:sport_app/model/news.dart';
import 'package:sport_app/repositories/network_manager.dart';

class ApiClient {
  static final ApiClient api = ApiClient._internal();
  ApiClient._internal();

  Future<News?> getAllNews() async {
    Map<String, dynamic>? param = {
      Application.apiToken: Application.apiTokenNumber,
    };
    final data = await NetWorkManager.shared.get(Application.newsAllUrl, param);
    News news = News.fromJson(data);
    return news;
  }

  Future<News?> getTopNews() async {
    Map<String, dynamic>? param = {
      Application.apiToken: Application.apiTokenNumber,
    };
    final data = await NetWorkManager.shared.get(Application.newsTopUrl, param);
    News news = News.fromJson(data);
    return news;
  }
}
