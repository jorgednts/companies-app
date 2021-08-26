import 'package:flutter/material.dart';


class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  var _successfulRequestResult = true;
  var _informationForUserToStartSearch = 'Clique na busca para iniciar';
  var _informationForUserNoResult = 'Nenhuma empresa foi encontrada para a busca realizada';

  List<Company> recoverCompanyList() {
    List<Company> list = [];
    Company company1 = Company(
        'assets/images/enterprise.png', 'Título 1', 'Tipo 1', 'País 1');
    Company company2 = Company(
        'assets/images/enterprise.png', 'Título 2', 'Tipo 2', 'País 2');
    Company company3 = Company(
        'assets/images/enterprise.png', 'Título 3', 'Tipo 3', 'País 3');
    Company company4 = Company(
        'assets/images/enterprise.png', 'Título 4', 'Tipo 4', 'País 4');
    Company company5 = Company(
        'assets/images/enterprise.png', 'Título 5', 'Tipo 5', 'País 5');
    Company company6 = Company(
        'assets/images/enterprise.png', 'Título 6', 'Tipo 6', 'País 6');
    Company company7 = Company(
        'assets/images/enterprise.png', 'Título 7', 'Tipo 7', 'País 7');
    Company company8 = Company(
        'assets/images/enterprise.png', 'Título 8', 'Tipo 8', 'País 8');
    Company company9 = Company(
        'assets/images/enterprise.png', 'Título 9', 'Tipo 9', 'País 9');
    Company company10 = Company(
        'assets/images/enterprise.png', 'Título 10', 'Tipo 10', 'País 1,');
    Company company11 = Company(
        'assets/images/enterprise.png', 'Título 11', 'Tipo 11', 'País 11');
    Company company12 = Company(
        'assets/images/enterprise.png', 'Título 12', 'Tipo 12', 'País 12');
    list.add(company1);
    list.add(company2);
    list.add(company3);
    list.add(company4);
    list.add(company5);
    list.add(company6);
    list.add(company7);
    list.add(company8);
    list.add(company9);
    list.add(company10);
    list.add(company11);
    list.add(company12);
    return list;
  }

  @override
  Widget build(BuildContext context) {
    var list = recoverCompanyList();

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
      body: SingleChildScrollView(
        child: SizedBox(
          child: Center(
            child: Column(
              children: [
                if(_successfulRequestResult) Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index){
                        return Card(
                          color: Colors.white,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(list[index].image, height: 100, width: 200,),
                              ),
                              Column(
                                children: [
                                  Text(list[index].name),
                                  Text(list[index].type),
                                  Text(list[index].country),
                                ],
                              ),
                            ],
                          ),
                        );
                      },),
                  ),
                ) else
                  Container(
                      child: Text(_informationForUserToStartSearch,
                        style: TextStyle(fontSize: 18),)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Company {
  String _image;
  String _name;
  String _type;
  String _country;

  Company(this._image, this._name, this._type, this._country);

  String get country => _country;

  String get type => _type;

  String get name => _name;

  String get image => _image;
}
