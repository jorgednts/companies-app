import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:ioasys_app/data/cache/enterprise/model/enterprise_cm.dart';
import 'package:ioasys_app/data/cache/enterprise/model/enterprise_type_cm.dart';
import 'package:ioasys_app/domain/model/user/user_tokens.dart';
import 'package:ioasys_app/presentation/enterprise/enterprise_details/result_screen.dart';
import 'package:ioasys_app/presentation/enterprise/enterprise_list/main_screen.dart';
import 'package:ioasys_app/presentation/login/login_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'di/setup_provider.dart';
import 'generated/l10n.dart';

Future<void> main() async {
  await runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    Hive
      ..init((await getApplicationDocumentsDirectory()).path)
      ..registerAdapter<EnterpriseCM>(EnterpriseCMAdapter())
      ..registerAdapter<EnterpriseTypeCM>(EnterpriseTypeCMAdapter());

    FluroRouter.appRouter
      ..define(
        '/',
        handler: Handler(
          handlerFunc: (context, params) => LoginScreen.create(context!),
        ),
      )
      ..define(
        'main-screen',
        handler: Handler(handlerFunc: (context, params) {
          final userTokens = context!.settings!.arguments as UserTokens;
          return MainScreen.create(context, userTokens);
        }),
      )
      ..define(
        'result-screen/:enterpriseId',
        handler: Handler(handlerFunc: (context, params) {
          final enterpriseId = int.parse(params['enterpriseId']![0]);
          final userTokens = context!.settings!.arguments as UserTokens;
          return ResultScreen.create(context, enterpriseId, userTokens);
        }),
      );

    runApp(MyApp.create());
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

class MyApp extends StatelessWidget {
  const MyApp({
    required this.firebaseAnalytics,
    Key? key,
  }) : super(key: key);
  final FirebaseAnalytics firebaseAnalytics;

  static Widget create() => Provider<FirebaseAnalytics>(
      create: (_) => FirebaseAnalytics(),
      builder: (context, _) =>
          MyApp(firebaseAnalytics: context.read<FirebaseAnalytics>()));

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: providers,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          onGenerateRoute: (settings) => FluroRouter.appRouter
              .matchRoute(context, settings.name, routeSettings: settings)
              .route,
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: firebaseAnalytics),
          ],
        ),
      );
}
