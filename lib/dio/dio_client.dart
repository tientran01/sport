import 'package:sport_app/application/application.dart';
import 'package:sport_app/dio/network_manager.dart';
import 'package:sport_app/model/news.dart';

class DioClient {
  static DioClient shared = DioClient._internal();
  DioClient._internal();

  Future<News?> getTopHeadlines() async {
    Map<String, dynamic>? param = {
      Application.countryParamKey: "us",
      Application.apiKey: Application.apiKeyNumber,
    };
    Map<String, dynamic>? data = await NetWorkManager.shared.get(
      Application.topHeadlines,
      param,
    );
    if (data != null) {
      News news = News.fromJson(data);
      return news;
    }
    return null;
  }

  Future<News?> getTopHeadlinesWithSource() async {
    Map<String, dynamic>? param = {
      Application.sourcesParamKey: Application.techcrunchParamValue,
      Application.apiKey: Application.apiKeyNumber,
    };
    Map<String, dynamic>? data = await NetWorkManager.shared.get(
      Application.topHeadlines,
      param,
    );
    if (data != null) {
      News news = News.fromJson(data);
      return news;
    }
    return null;
  }

  Future<News?> getEverything({required String endpoint}) async {
    Map<String, dynamic>? param = {
      Application.qParamKey: endpoint,
      Application.apiKey: Application.apiKeyNumber,
    };
    Map<String, dynamic>? data =
        await NetWorkManager.shared.get(Application.everything, param);
    if (data != null) {
      News news = News.fromJson(data);
      return news;
    }
    return null;
  }
}
