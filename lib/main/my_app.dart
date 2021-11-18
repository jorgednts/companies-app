import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:ioasys_app/di/setup_provider.dart';
import 'package:ioasys_app/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        ),
      );
}
