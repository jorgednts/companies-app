import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ioasys_app/bloc/enterprise/main_bloc.dart';
import 'package:ioasys_app/constants/constants_images.dart';
import 'package:ioasys_app/data/remote/enterprise/remote_data_source/enterprise_remote_data_source.dart';
import 'package:ioasys_app/data/repository/enterprise_repository/enterprise_data_repository.dart';
import 'package:ioasys_app/data/repository/enterprise_repository/enterprise_repository.dart';
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
  late EnterpriseRemoteDataSource _enterpriseRemoteDataSource;
  late EnterpriseDataRepository _enterpriseDataRepository;
  late MainBloc _mainBloc;

  @override
  void initState() {
    super.initState();
    _enterpriseRemoteDataSource = EnterpriseRemoteDataSource(Dio());
    _enterpriseDataRepository =
        EnterpriseRepository(_enterpriseRemoteDataSource);
    _mainBloc = MainBloc(_enterpriseDataRepository);
  }

  @override
  void dispose() {
    _mainBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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
                        child: const Text(
                      'Clique para iniciar a busca',
                      style: const TextStyle(fontSize: 18),
                    )),
                ],
              ),
            ),
          ),
        ),
      );
}
