import 'package:sport_app/pages/article/article_screen.dart';
import 'package:sport_app/pages/article/create_new_article.dart';
import 'package:sport_app/pages/article/detail_article_screen.dart';
import 'package:sport_app/pages/article/your_article_screen.dart';
import 'package:sport_app/pages/auth/password/check_email_screen.dart';
import 'package:sport_app/pages/auth/password/create_new_password_screen.dart';
import 'package:sport_app/pages/auth/password/input_email_reset_screen.dart';
import 'package:sport_app/pages/auth/phone/phone_input_screen.dart';
import 'package:sport_app/pages/auth/phone/phone_otp_screen.dart';
import 'package:sport_app/pages/auth/sign_up/sign_up_screen.dart';
import 'package:sport_app/pages/auth/login/login_screen.dart';
import 'package:sport_app/pages/home/article_sort_by_name.dart';
import 'package:sport_app/pages/home/home_screen.dart';
import 'package:sport_app/pages/auth/splash/splash_screen.dart';
import 'package:sport_app/pages/main_screen.dart';
import 'package:sport_app/pages/notification/notification_detail_screen.dart';
import 'package:sport_app/pages/notification/notification_screen.dart';
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
    AppRouteName.main: (BuildContext context) => const MainScreen(),
    AppRouteName.home: (BuildContext context) => const HomeScreen(),
    AppRouteName.profile: (BuildContext context) => const ProfileScreen(),
    AppRouteName.phoneInput: (BuildContext context) => const PhoneInputScreen(),
    AppRouteName.phoneOtp: (BuildContext context) => const PhoneOTPScreen(),
    AppRouteName.inputEmailReset: (BuildContext context) => const InputEmailResetScreen(),
    AppRouteName.createNewPassword: (BuildContext context) => const CreateNewPasswordScreen(),
    AppRouteName.checkEmail: (BuildContext context) => const CheckEmailScreen(),
    AppRouteName.notification: (BuildContext context) => const NotificationScreen(),
    AppRouteName.notificationDetail: (BuildContext context) => const NotificationDetailScreen(),
    AppRouteName.detailArticle: (BuildContext context) => const DetailArticleScreen(),
    AppRouteName.article: (BuildContext context) => const ArticleScreen(),
    AppRouteName.yourArticle: (BuildContext context) => const YourArticleScreen(),
    AppRouteName.createNewArticle: (BuildContext context) => const CreateNewArticle(),
    AppRouteName.setting: (BuildContext context) => const SettingScreen(),
    AppRouteName.articleSortByName: (BuildContext context) => ArticleSortByName(),
    AppRouteName.videoPlayer: (BuildContext context) => const VideoPlayerScreen(),
  };
}
