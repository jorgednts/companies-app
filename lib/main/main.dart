import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ioasys_app/data/cache_model/enterprise/model/enterprise_cm.dart';
import 'package:ioasys_app/data/cache_model/enterprise/model/enterprise_type_cm.dart';
import 'package:ioasys_app/domain/user/user_tokens.dart';
import 'package:ioasys_app/main/my_app.dart';
import 'package:ioasys_app/view/login_view/login_screen.dart';
import 'package:ioasys_app/view/main_view/main_screen.dart';
import 'package:ioasys_app/view/result_view/result_screen.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

  runApp(const MyApp());
}
