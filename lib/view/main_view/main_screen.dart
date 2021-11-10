import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ioasys_app/bloc/enterprise/async_snapshot_response_view.dart';
import 'package:ioasys_app/bloc/enterprise/main_bloc.dart';
import 'package:ioasys_app/data/remote/enterprise/remote_data_source/enterprise_remote_data_source.dart';
import 'package:ioasys_app/data/remote/shared/view_state/main_view_state.dart';
import 'package:ioasys_app/data/repository/enterprise_repository/enterprise_data_repository.dart';
import 'package:ioasys_app/data/repository/enterprise_repository/enterprise_repository.dart';
import 'package:ioasys_app/domain/user/user_tokens.dart';
import 'package:ioasys_app/generated/l10n.dart';
import 'package:ioasys_app/view/main_view/widgets/enterprise_list.dart';

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
  late StreamSubscription _viewStateStreamSubscription;

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
    _viewStateStreamSubscription.cancel();
    super.dispose();
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
                if (typedEnterpriseName.isNotEmpty) {
                  _mainBloc.getEnterpriseList(
                      typedEnterpriseName,
                      widget.userTokens.accessToken,
                      widget.userTokens.uid,
                      widget.userTokens.client);
                }
              },
            ),
          ),
        ),
      ),
      body: StreamBuilder<MainViewState>(
        stream: _mainBloc.mainViewState,
        initialData: InitialState(),
        builder: (context, snapshot) => AsyncSnapshotResponseView<
            LoadingState,
            GenericErrorState,
            NetworkErrorState,
            NoResult,
            SuccessState,
            InitialState>(
          snapshot: snapshot,
          successWidgetBuilder: (context, successState) {
            final enterpriseList = successState.enterprises;
            return EnterpriseList(enterpriseList: enterpriseList);
          },
        ),
      ));
}
