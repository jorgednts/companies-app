import 'package:flutter/material.dart';
import 'package:ioasys_app/constants/constants_images.dart';
import 'package:ioasys_app/domain/user/user_tokens.dart';
import 'package:ioasys_app/view/result_view/result_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    required this.userTokens,
    Key? key,
  }) : super(key: key);
  final UserTokens userTokens;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _successfulRequestResult = true;
  final _informationForUserToStartSearch = 'Clique na busca para iniciar';

  List<Company> recoverCompanyList() {
    var list = <Company>[];
    final company1 =
        Company('assets/images/enterprise.png', 'Título 1', 'Tipo 1', 'País 1');
    final company2 =
        Company('assets/images/enterprise.png', 'Título 2', 'Tipo 2', 'País 2');
    final company3 =
        Company('assets/images/enterprise.png', 'Título 3', 'Tipo 3', 'País 3');
    final company4 =
        Company('assets/images/enterprise.png', 'Título 4', 'Tipo 4', 'País 4');
    final company5 =
        Company('assets/images/enterprise.png', 'Título 5', 'Tipo 5', 'País 5');
    final company6 =
        Company('assets/images/enterprise.png', 'Título 6', 'Tipo 6', 'País 6');
    final company7 =
        Company('assets/images/enterprise.png', 'Título 7', 'Tipo 7', 'País 7');
    final company8 =
        Company('assets/images/enterprise.png', 'Título 8', 'Tipo 8', 'País 8');
    final company9 =
        Company('assets/images/enterprise.png', 'Título 9', 'Tipo 9', 'País 9');
    final company10 = Company(
        'assets/images/enterprise.png', 'Título 10', 'Tipo 10', 'País 1,');
    final company11 = Company(
        'assets/images/enterprise.png', 'Título 11', 'Tipo 11', 'País 11');
    final company12 = Company(
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
      backgroundColor: const Color(0xffebe9d7),
      appBar: AppBar(
        backgroundColor: const Color(0xffee4c77),
        title: Center(
          child: Image.asset(
            ConstantsImages.imageLogoInAppBar,
            width: 98,
            height: 22,
            alignment: FractionalOffset.center,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ResultScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Center(
            child: Column(
              children: [
                if (_successfulRequestResult)
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(4),
                          child: Card(
                            color: Colors.white,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Image.asset(
                                    list[index].image,
                                    height: 100,
                                    width: 200,
                                  ),
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
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  Container(
                      child: Text(
                    _informationForUserToStartSearch,
                    style: const TextStyle(fontSize: 18),
                  )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Company {
  Company(this.image, this.name, this.type, this.country);

  final String image;
  final String name;
  final String type;
  final String country;
}
