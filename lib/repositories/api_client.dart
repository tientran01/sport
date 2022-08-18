
import 'package:sport_app/dio/end_point.dart';
import 'package:sport_app/model/news.dart';
import 'package:sport_app/dio/network_manager.dart';

class ApiClient {
  static final ApiClient api = ApiClient._internal();
  ApiClient._internal();

  Future<News?> getTopHeadlines() async {
    Map<String, dynamic>? param = {
      EndPoint.countryParamKey: "us",
      EndPoint.apiKey: EndPoint.apiKeyNumber,
    };
    Map<String, dynamic>? data =
        await NetWorkManager.shared.get(EndPoint.topHeadlines, param);
    if (data != null) {
      News news = News.fromJson(data);
      return news;
    }
    return null;
  }

  Future<News?> getTopHeadlinesWithSource() async {
    Map<String, dynamic>? param = {
      EndPoint.sourcesParamKey: EndPoint.techcrunchParamValue,
      EndPoint.apiKey: EndPoint.apiKeyNumber,
    };
    Map<String, dynamic>? data =
        await NetWorkManager.shared.get(EndPoint.topHeadlines, param);
    if (data != null) {
      News news = News.fromJson(data);
      return news;
    }
    return null;
  }

  Future<News?> getEverything({required String endpoint}) async {
    Map<String, dynamic>? param = {
      EndPoint.qParamKey: endpoint,
      EndPoint.apiKey: EndPoint.apiKeyNumber,
    };
    Map<String, dynamic>? data =
        await NetWorkManager.shared.get(EndPoint.everything, param);
    if (data != null) {
      News news = News.fromJson(data);
      return news;
    }
    return null;
  }
}
