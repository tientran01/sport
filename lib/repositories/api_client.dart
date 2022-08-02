import 'package:sport_app/application/application.dart';
import 'package:sport_app/model/news.dart';
import 'package:sport_app/repositories/network_manager.dart';

class ApiClient {
  static final ApiClient api = ApiClient._internal();
  ApiClient._internal();

  Future<News?> getTopHeadlines() async {
    Map<String, dynamic>? param = {
      Application.countryParamKey: "us",
      Application.apiKey: Application.apiKeyNumber,
    };
    final data =
        await NetWorkManager.shared.get(Application.topHeadlines, param);
    News news = News.fromJson(data);
    return news;
  }

  Future<News?> getTopHeadlinesWithSource() async {
    Map<String, dynamic>? param = {
      Application.sourcesParamKey: Application.techcrunchParamValue,
      Application.apiKey: Application.apiKeyNumber,
    };
    final data =
        await NetWorkManager.shared.get(Application.topHeadlines, param);
    News news = News.fromJson(data);
    return news;
  }

  Future<News?> getApple() async {
    Map<String, dynamic>? param = {
      Application.qParamKey: Application.appleParamValue,
      Application.apiKey: Application.apiKeyNumber,
    };
    final data = await NetWorkManager.shared.get(Application.everything, param);
    News news = News.fromJson(data);
    return news;
  }

  Future<News?> getBitcoin() async {
    Map<String, dynamic>? param = {
      Application.qParamKey: Application.bitcoinParamValue,
      Application.apiKey: Application.apiKeyNumber,
    };
    final data = await NetWorkManager.shared.get(Application.everything, param);
    News news = News.fromJson(data);
    return news;
  }

  Future<News?> getTesla() async {
    Map<String, dynamic>? param = {
      Application.qParamKey: Application.teslaParamValue,
      Application.apiKey: Application.apiKeyNumber,
    };
    final data = await NetWorkManager.shared.get(Application.everything, param);
    News news = News.fromJson(data);
    return news;
  }
}
