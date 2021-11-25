import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ioasys_app/data/cache/enterprise/model/enterprise_cm.dart';
import 'package:ioasys_app/data/cache/enterprise/model/enterprise_type_cm.dart';
import 'package:ioasys_app/domain/model/user/user_tokens.dart';
import 'package:ioasys_app/main/my_app.dart';
import 'package:ioasys_app/presentation/enterprise/enterprise_details/result_screen.dart';
import 'package:ioasys_app/presentation/login/login_screen.dart';
import 'package:ioasys_app/presentation/enterprise/enterprise_list/main_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_core/firebase_core.dart';

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
