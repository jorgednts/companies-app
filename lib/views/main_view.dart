import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  var _successfulRequestResult = false;
  var _informationForUserToStartSearch = 'Clique na busca para iniciar';
  var _informationForUserNoResult = 'Nenhuma empresa foi encontrada para a busca realizada';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffebe9d7),
      appBar: AppBar(
          backgroundColor: Color(0xffee4c77),
          title: Center(
            child: Image.asset(
              'assets/images/logo_nav.png',
              width: 98,
              height: 22,
              alignment: FractionalOffset.center,
            ),
          ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).pushNamed('/result');
            },
          ),
        ],
      ),
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if(_successfulRequestResult) SizedBox() else Container(
                    child: Text(_informationForUserToStartSearch, style: TextStyle(fontSize: 18),)),
              ],
            )
          ),
      ) ,
    );
  }
}
