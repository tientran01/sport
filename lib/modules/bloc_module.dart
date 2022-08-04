import 'package:sport_app/bloc/bloc.dart';
import 'package:sport_app/main.dart';

class BlocModule {
  BlocModule._();
  static void provider() async {
    getIt.registerLazySingleton<SplashBloc>(() => SplashBloc());
    getIt.registerLazySingleton<LoginBloc>(() => LoginBloc());
    getIt.registerLazySingleton<SignUpBloc>(() => SignUpBloc());
    getIt.registerLazySingleton<HomeBloc>(() => HomeBloc());
    getIt.registerLazySingleton<ProfileBloc>(() => ProfileBloc());
    getIt.registerLazySingleton<PhoneAuthBloc>(() => PhoneAuthBloc());
    getIt.registerLazySingleton<VerifyOtpBloc>(() => VerifyOtpBloc());
    getIt.registerLazySingleton<ForgetPasswordBloc>(() => ForgetPasswordBloc());
    getIt.registerLazySingleton<NotificationBloc>(() => NotificationBloc());
    getIt.registerLazySingleton<ArticleBloc>(() => ArticleBloc());
    getIt.registerLazySingleton<YourArticleBloc>(() => YourArticleBloc());
  }
}
