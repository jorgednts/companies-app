import 'package:flutter/material.dart';

class ResultView extends StatefulWidget {
  const ResultView({Key? key}) : super(key: key);

  @override
  _ResultViewState createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  var _enterpriseName = 'Nome da empresa';
  var _enterpriseDescription = 'Descrição da empresa';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffee4c77),
        title: Text(_enterpriseName),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Image.asset('assets/images/enterprise.png', height: 200, width: 400,),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Text(_enterpriseDescription, style: TextStyle(fontSize: 16), textAlign: TextAlign.justify,),
              ),
              SizedBox(
                  height: 20,
              ),
            ],
          ),
          )
        ),
    );
  }
}
