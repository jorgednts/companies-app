import 'package:flutter/material.dart';
import 'package:ioasys_app/view/login_view/login_screen.dart';
import 'package:ioasys_app/view/main_view/main_screen.dart';
import 'package:ioasys_app/view/result_view/result_screen.dart';
import 'package:ioasys_app/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/main': (context) => MainScreen(),
        '/result': (context) => ResultScreen(),
      },
    );
  }
}
