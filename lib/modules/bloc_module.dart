import 'package:sport_app/bloc/drawer/bloc/drawer_bloc.dart';
import 'package:sport_app/bloc/notification/bloc/notification_bloc.dart';
import 'package:sport_app/bloc/profile/bloc/profile_bloc.dart';
import 'package:sport_app/main.dart';
import '../bloc/foget_password/bloc/forget_password_bloc.dart';
import '../bloc/home/bloc/home_bloc.dart';
import '../bloc/login/bloc/login_bloc.dart';
import '../bloc/phone_auth/bloc/phone_auth_bloc.dart';
import '../bloc/sign_up/bloc/sign_up_bloc.dart';
import '../bloc/splash/bloc/splash_bloc.dart';
import '../bloc/verify_otp_bloc/bloc/verify_otp_bloc.dart';

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
    getIt.registerLazySingleton<DrawerBloc>(() => DrawerBloc());
  }
}
