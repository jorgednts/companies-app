import 'package:flutter/material.dart';
import 'package:ioasys_app/views/login_view.dart';
import 'package:ioasys_app/views/main_view.dart';
import 'package:ioasys_app/views/result_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: LoginView(),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginView(),
        '/main': (context) => MainView(),
        '/result': (context) => ResultView(),
      },
    );
  }
}
