import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ioasys_app/bloc/enterprise/main_bloc.dart';
import 'package:ioasys_app/data/remote/enterprise/remote_data_source/enterprise_remote_data_source.dart';
import 'package:ioasys_app/data/remote/shared/view_state/main_view_state.dart';
import 'package:ioasys_app/data/repository/enterprise_repository/enterprise_data_repository.dart';
import 'package:ioasys_app/data/repository/enterprise_repository/enterprise_repository.dart';
import 'package:ioasys_app/domain/enterprise/enterprise_model.dart';
import 'package:ioasys_app/domain/user/user_tokens.dart';
import 'package:ioasys_app/generated/l10n.dart';
import 'package:ioasys_app/view/main_view/widgets/enterprise_list.dart';
import 'package:ioasys_app/view/main_view/widgets/empty_enterprise_list.dart';

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
  List<EnterpriseModel> _enterpriseList = [];

  @override
  void initState() {
    super.initState();
    _enterpriseRemoteDataSource = EnterpriseRemoteDataSource(Dio());
    _enterpriseDataRepository =
        EnterpriseRepository(_enterpriseRemoteDataSource);
    _mainBloc = MainBloc(_enterpriseDataRepository);
    _setupStreamIsLoading();
  }

  @override
  void dispose() {
    _mainBloc.dispose();
    super.dispose();
  }

  void _setupStreamViewState() {
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

  void _setupStreamIsLoading() {
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
                final typedEnterpriseName =
                    _enterpriseNameToSearchController.text.toString();
                if(typedEnterpriseName.isNotEmpty){
                  _mainBloc.getEnterpriseList(
                      typedEnterpriseName,
                      widget.userTokens.accessToken,
                      widget.userTokens.uid,
                      widget.userTokens.client);
                  _setupStreamViewState();
                }
              },
            ),
          ),
        ),
      ),
      body: _enterpriseList.isNotEmpty
          ? EnterpriseList(enterpriseList: _enterpriseList)
          : const EmptyEnterpriseList());

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
}
