import 'package:flutter/material.dart';
import 'package:ioasys_app/view/login_view/login_view.dart';
import 'package:ioasys_app/view/main_view/main_view.dart';
import 'package:ioasys_app/view/result_view/result_view.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginView(),
        '/main': (context) => MainView(),
        '/result': (context) => ResultView(),
      },
    );
  }
}
