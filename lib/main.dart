import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:sport_app/bloc/foget_password/bloc/forget_password_bloc.dart';
import 'package:sport_app/bloc/home/bloc/home_bloc.dart';
import 'package:sport_app/bloc/notification/bloc/notification_bloc.dart';
import 'package:sport_app/bloc/phone_auth/bloc/phone_auth_bloc.dart';
import 'package:sport_app/bloc/profile/bloc/profile_bloc.dart';
import 'package:sport_app/bloc/sign_up/bloc/sign_up_bloc.dart';
import 'package:sport_app/bloc/splash/bloc/splash_bloc.dart';
import 'package:sport_app/bloc/verify_otp_bloc/bloc/verify_otp_bloc.dart';
import 'package:sport_app/helper/firebase_helper.dart';
import 'package:sport_app/helper/shared_preferences_helper.dart';
import 'package:sport_app/modules/bloc_module.dart';
import 'package:sport_app/resource/app_route_name.dart';
import 'package:sport_app/resource/app_strings.dart';
import 'package:sport_app/router/navigation_service.dart';
import 'package:sport_app/router/router_name.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'bloc/login/bloc/login_bloc.dart';
import 'helper/notification_service.dart';

final GetIt getIt = GetIt.instance;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  BlocModule.provider();
  NotificationService.shared.setup();
  await SharedPreferencesHelper.shared.setUpSharedPreferences();
  FirebaseHelper.shared.registerNotification();
  FirebaseHelper.shared.getToken();
  FirebaseHelper.shared.setupInteractedMessage();
  FlutterAppBadger.removeBadge();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SplashBloc()),
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => SignUpBloc()),
        BlocProvider(create: (_) => HomeBloc()),
        BlocProvider(create: (_) => ProfileBloc()),
        BlocProvider(create: (_) => PhoneAuthBloc()),
        BlocProvider(create: (_) => VerifyOtpBloc()),
        BlocProvider(create: (_) => ForgetPasswordBloc()),
        BlocProvider(create: (_) => NotificationBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    String appBadgeSupported;
    try {
      bool res = await FlutterAppBadger.isAppBadgeSupported();
      if (res) {
        appBadgeSupported = AppStrings.supported;
      } else {
        appBadgeSupported = AppStrings.notSupported;
      }
    } on PlatformException {
      appBadgeSupported = AppStrings.failedSupport;
    }
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouteName.splash,
      routes: RouteName.route,
      builder: EasyLoading.init(),
    );
  }
}
