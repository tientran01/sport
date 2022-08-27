import 'package:sport_app/model/category.dart';
import 'package:sport_app/model/video.dart';
import 'package:sport_app/resource/resource.dart';

class AppStrings {
  static const String success = "Success";
  static const String loading = "Loading";
  static const String error = "Error";
  static const String hotNews = "Tin nổi bật";
  static const String mostInterested = "Được quan tâm nhất";

  static List<Category> categories = [
    Category(
      text: Application.top,
      color: AppColor.gargoyleGas,
    ),
    Category(
      text: Application.appleParamValue,
      color: AppColor.blue,
    ),
    Category(
      text: Application.bitcoinParamValue,
      color: AppColor.gainsboro,
    ),
    Category(
      text: Application.teslaParamValue,
      color: AppColor.jetStream,
    ),
  ];

  static List<Video> videos = [
    Video(
      id: 1,
      title:
          "Stocks making the biggest moves premarket: Eli Lilly, Cigna, Restaurant Brands and more - CNBC",
      videoUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
      thumbnailUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg",
      timeline: "10.53",
      describe:
          "The hottest place on earth is soaked after record rainfall, trapping visitors, staff and cars for hours.",
    ),
    Video(
      id: 2,
      title:
          "BOE Raises Rates by Most Since 1995, Warns of Long Recession - Bloomberg",
      videoUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
      thumbnailUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg",
      timeline: "09:56",
      describe:
          "WASHINGTON (AP) — The Senate parliamentarian on Saturday dealt a blow to Democrats’ plan for curbing drug prices but left the rest of their sprawling economic bill largely intact as party leaders prepared for first votes on a package containing many of Presid",
    ),
    Video(
      id: 3,
      title: "For Bigger Blazes",
      videoUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
      thumbnailUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg",
      timeline: "0:15",
      describe:
          "Chelsea also survived a slog while Aston Villa disappointed for Steven Gerrard",
    ),
    Video(
      id: 4,
      title: "For Bigger Escape",
      videoUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
      thumbnailUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerEscapes.jpg",
      timeline: "0:15",
      describe:
          "Some legal experts said they were surprised by his conduct and questioned whether it was a calculated risk to boost his appeal to fans.",
    ),
    Video(
      id: 5,
      title:
          "Restaurant Brands International earnings top estimates, fueled by stronger Tim Hortons, Burger King sales - CNBC",
      videoUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
      thumbnailUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerFun.jpg",
      timeline: "01:00",
      describe:
          "Elon Musk’s latest shenanigans involve challenging Twitter CEO Parag Agrawal to a “public debate” about how many bots Twitter has on the platform.",
    ),
    Video(
      id: 6,
      title:
          "Alibaba shares pop 5% after earnings beat — but reports first flat revenue growth in history - CNBC",
      videoUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
      thumbnailUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerJoyrides.jpg",
      timeline: "0:15",
      describe:
          "Bryant Young received a standing ovation from fans at the Hall of Fame ceremony.",
    ),
  ];
}

class AppCollection {
  static const String userInformation = "users";
}

class AppFolder {
  static const String imageUser = "imageUser/";
}

class AppFieldName {
  static const String photoUrl = "photoUrl";
  static const String tokens = "tokens";
  static const String displayName = "displayName";
}

class AppKeyName {
  static const String uid = "uid";
  static const String count = "count";
  static const String badge = "badge";
  static const String badgeCount = 'badgeCount';
  static const String token = "token";
  static const String favoritesBox = "favorites";
  static const String article = "article";
  static const String video = "video";
  static const int version = 1;
  static const String newsDB = "news.db";
  static const String videoTable = "Video";
  static const String yourArticleTable = "YourArticle";
  static const String languageCode = "languageCode";
  static const String english = 'en';
  static const String vietnamese = 'vi';
}

class Application {
  static const String topHeadlines = "/top-headlines";
  static const String everything = "/everything";
  static const String apiKey = "apiKey";
  static const String apiKeyNumber = "e883f1216079444a8a8867c06341edd6";
  static const String countryParamKey = "country";
  static const String sourcesParamKey = "sources";
  static const String techcrunchParamValue = "techcrunch";
  static const String qParamKey = "q";
  static const String appleParamValue = "apple";
  static const String teslaParamValue = "tesla";
  static const String bitcoinParamValue = "bitcoin";
  static const String top = "top";
}
