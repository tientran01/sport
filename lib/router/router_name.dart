import 'package:sport_app/pages/article/apple_article_screen.dart';
import 'package:sport_app/pages/article/article_screen.dart';
import 'package:sport_app/pages/article/bitcoin_article_screen.dart';
import 'package:sport_app/pages/your_article/create_new_article.dart';
import 'package:sport_app/pages/article/detail_article_screen.dart';
import 'package:sport_app/pages/article/tesla_article_screen.dart';
import 'package:sport_app/pages/article/top_article_screen.dart';
import 'package:sport_app/pages/your_article/edit_your_article.dart';
import 'package:sport_app/pages/your_article/your_article_screen.dart';
import 'package:sport_app/pages/auth/sign_up/sign_up_screen.dart';
import 'package:sport_app/pages/auth/login/login_screen.dart';
import 'package:sport_app/pages/favorites/favorite_screen.dart';
import 'package:sport_app/pages/home/article_sort_by_name.dart';
import 'package:sport_app/pages/home/home_screen.dart';
import 'package:sport_app/pages/auth/splash/splash_screen.dart';
import 'package:sport_app/pages/app.dart';
import 'package:sport_app/pages/profile/profile_screen.dart';
import 'package:sport_app/pages/setting/setting_screen.dart';
import 'package:sport_app/pages/video_player/video_player_screen.dart';
import 'package:sport_app/resource/app_route_name.dart';
import 'package:flutter/material.dart';

class RouteName {
  static Map<String, WidgetBuilder> route = {
    AppRouteName.splash: (BuildContext context) => const SplashScreen(),
    AppRouteName.login: (BuildContext context) => const LoginScreen(),
    AppRouteName.signUp: (BuildContext context) => const SignUpScreen(),
    AppRouteName.app: (BuildContext context) => const App(),
    AppRouteName.home: (BuildContext context) => HomeScreen(),
    AppRouteName.profile: (BuildContext context) => const ProfileScreen(),
    AppRouteName.detailArticle: (BuildContext context) =>
        const DetailArticleScreen(),
    AppRouteName.article: (BuildContext context) => const ArticleScreen(),
    AppRouteName.yourArticle: (BuildContext context) =>
        const YourArticleScreen(),
    AppRouteName.createNewArticle: (BuildContext context) =>
        const CreateNewArticle(),
    AppRouteName.setting: (BuildContext context) => const SettingScreen(),
    AppRouteName.articleSortByName: (BuildContext context) =>
        const ArticleSortByName(),
    AppRouteName.videoPlayer: (BuildContext context) =>
        const VideoPlayerScreen(),
    AppRouteName.favorite: (BuildContext context) => const FavoriteScreen(),
    AppRouteName.topArticle: (BuildContext context) => const TopArticleScreen(),
    AppRouteName.appleArticle: (BuildContext context) =>
        const AppleArticleScreen(),
    AppRouteName.bitcoinArticle: (BuildContext context) =>
        const BitcoinArticleScreen(),
    AppRouteName.teslaArticle: (BuildContext context) =>
        const TeslaArticleScreen(),
    AppRouteName.editYourArticle: (BuildContext context) => const EditYourArticleScreen(),
  };
}
