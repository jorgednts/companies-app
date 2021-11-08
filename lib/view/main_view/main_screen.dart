import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ioasys_app/bloc/enterprise/main_bloc.dart';
import 'package:ioasys_app/constants/constants_images.dart';
import 'package:ioasys_app/data/remote/enterprise/remote_data_source/enterprise_remote_data_source.dart';
import 'package:ioasys_app/data/remote/shared/view_state/main_view_state.dart';
import 'package:ioasys_app/data/repository/enterprise_repository/enterprise_data_repository.dart';
import 'package:ioasys_app/data/repository/enterprise_repository/enterprise_repository.dart';
import 'package:ioasys_app/domain/enterprise/enterprise_model.dart';
import 'package:ioasys_app/domain/user/user_tokens.dart';
import 'package:ioasys_app/generated/l10n.dart';
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
  final TextEditingController _enterpriseNameToSearchController =
      TextEditingController();
  late EnterpriseRemoteDataSource _enterpriseRemoteDataSource;
  late EnterpriseDataRepository _enterpriseDataRepository;
  late MainBloc _mainBloc;
  late List<EnterpriseModel> _enterpriseList;

  @override
  void initState() {
    super.initState();
    _enterpriseRemoteDataSource = EnterpriseRemoteDataSource(Dio());
    _enterpriseDataRepository =
        EnterpriseRepository(_enterpriseRemoteDataSource);
    _mainBloc = MainBloc(_enterpriseDataRepository);
    _setupStreams();
  }

  @override
  void dispose() {
    _mainBloc.dispose();
    super.dispose();
  }

  void _setupStreams() {
    _mainBloc.isLoading.listen((isLoading) {
      if (isLoading) {
        showDialog(
            context: context,
            builder: (context) => const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                    backgroundColor: Colors.transparent,
                  ),
                ));
      } else {
        Navigator.pop(context);
      }
    });
    _mainBloc.mainViewState.listen((viewState) {
      if (viewState is SuccessState) {
        _enterpriseList = viewState.enterprises;
      } else if (viewState is GenericErrorState) {
        _showAlertDialog(S.of(context).alertDialogMessageGenericError);
      } else {
        _showAlertDialog(S.of(context).alertDialogMessageNetworkError);
      }
    });
  }

  void _showAlertDialog(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(S.of(context).alertDialogTitle),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(S.of(context).alertDialogButton),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xffebe9d7),
        appBar: AppBar(
          backgroundColor: const Color(0xffee4c77),
          title: TextField(
            controller: _enterpriseNameToSearchController,
            decoration: InputDecoration(
              hintText: S.of(context).mainScreenHintTextAppBar,
              hintStyle: const TextStyle(color: Colors.black26),
              labelStyle: const TextStyle(color: Colors.grey),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  _mainBloc.getEnterpriseList(
                      _enterpriseNameToSearchController.text.toString(),
                      widget.userTokens.accessToken,
                      widget.userTokens.uid,
                      widget.userTokens.client);
                },
              ),
            ),
          ),
        ),
        body: _enterpriseList.isNotEmpty
            ? ListView.builder(
                itemCount: _enterpriseList.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(4),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ResultScreen()),
                      );
                    },
                    child: Card(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: FadeInImage(
                              height: 100,
                              width: 80,
                              image: NetworkImage(_enterpriseList[index].photo),
                              placeholder: const AssetImage(
                                  ConstantsImages.imageLoading),
                              imageErrorBuilder: (context, error, stackTrace) =>
                                  Image.asset(ConstantsImages.imageError,
                                      height: 100,
                                      width: 80,
                                      fit: BoxFit.fitWidth),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _enterpriseList[index].enterpriseName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  _enterpriseList[index]
                                      .enterpriseType
                                      .enterpriseTypeName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10),
                                ),
                                Text(
                                  _enterpriseList[index].country,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Container(
                child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
                child: Text(
                  S.of(context).mainScreenNoEnterpriseResult,
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              )),
      );
}
