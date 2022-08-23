import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:sport_app/bloc/bloc.dart';
import 'package:sport_app/bloc/search/bloc/search_bloc.dart';
import 'package:sport_app/cubit/news/most_interested_news/cubit/most_interested_news_cubit.dart';
import 'package:sport_app/helper/firebase_helper.dart';
import 'package:sport_app/helper/shared_preferences_helper.dart';
import 'package:sport_app/helper/sql_helper.dart';
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    FirebaseHelper.shared.setupInteractedMessage();
    FlutterAppBadger.removeBadge();
    await SQLHelper.shared.initDatabase();
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
          BlocProvider(create: (_) => YourArticleBloc()),
          BlocProvider(create: (_) => FavoriteBloc()),
          BlocProvider(create: (_) => SearchBloc()),
          BlocProvider(create: (_) => HotNewsCubit()),
          BlocProvider(create: (_) => MostInterestedNewsCubit()),
          BlocProvider(create: (_) => TeslaNewsCubit()),
          BlocProvider(create: (_) => AppleNewsCubit()),
        ],
        child: const MyApp(),
      ),
    );
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}