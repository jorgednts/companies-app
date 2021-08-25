import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffebe9d7),
      appBar: AppBar(
          backgroundColor: Color(0xffee4c77),
          title: Center(
            child: Image.asset(
              'assets/images/logo.png',
              width: 98,
              height: 22,
              alignment: FractionalOffset.center,
            ),
          ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
