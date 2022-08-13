import 'package:sport_app/bloc/bloc.dart';
import 'package:sport_app/bloc/search/bloc/search_bloc.dart';
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
    getIt.registerLazySingleton<YourArticleBloc>(() => YourArticleBloc());
    getIt.registerLazySingleton<FavoriteBloc>(() => FavoriteBloc());
    getIt.registerLazySingleton<SearchBloc>(() => SearchBloc());
    getIt.registerLazySingleton<HotNewsBloc>(() => HotNewsBloc());
    getIt.registerLazySingleton<MostInterestedNewsBloc>(
        () => MostInterestedNewsBloc());
    getIt.registerLazySingleton<TeslaNewsBloc>(() => TeslaNewsBloc());
    getIt.registerLazySingleton<AppleNewsBloc>(() => AppleNewsBloc());
  }
}
