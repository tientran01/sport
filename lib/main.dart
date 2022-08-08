import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:sport_app/bloc/bloc.dart';
import 'package:sport_app/helper/firebase_helper.dart';
import 'package:sport_app/helper/shared_preferences_helper.dart';
import 'package:sport_app/modules/bloc_module.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sport_app/router/navigation_service.dart';
import 'package:sport_app/router/router_name.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'helper/notification_service.dart';

final GetIt getIt = GetIt.instance;

Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    BlocModule.provider();
    NotificationService.shared.setup();
    await SharedPreferencesHelper.shared.setUpSharedPreferences();
    FirebaseHelper.shared.registerNotification();
    FirebaseHelper.shared.setupToken();
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
          BlocProvider(create: (_) => ArticleBloc()),
          BlocProvider(create: (_) => YourArticleBloc()),
          BlocProvider(create: (_) => FavoriteBloc()),
        ],
        child: const MyApp(),
      ),
    );
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
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
    // ignore: avoid_print
    print('isAppbageSupport${FlutterAppBadger.isAppBadgeSupported()}');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouteName.splash,
      routes: RouteName.route,
      builder: EasyLoading.init(),
      theme: ThemeData(
        backgroundColor: AppColor.ghostWhite,
      ),
    );
  }
}
