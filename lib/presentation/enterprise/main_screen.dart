import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ioasys_app/domain/model/user/user_tokens.dart';
import 'package:ioasys_app/domain/use_case/get_enterprise_list_use_case.dart';
import 'package:ioasys_app/presentation/common/async_snapshot_response_main_view.dart';
import 'package:ioasys_app/presentation/enterprise/enterprise_list.dart';
import 'package:ioasys_app/presentation/enterprise/main_bloc.dart';
import 'package:ioasys_app/data/remote/shared/view_state/main_view_state.dart';
import 'package:ioasys_app/generated/l10n.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    required this.userTokens,
    required this.mainBloc,
    Key? key,
  }) : super(key: key);
  final UserTokens userTokens;
  final MainBloc mainBloc;

  static Widget create(BuildContext context, UserTokens userTokens) =>
      ProxyProvider<GetEnterpriseListUseCase, MainBloc>(
        update: (context, getEnterpriseListUseCase, bloc) =>
            bloc ?? MainBloc(getEnterpriseListUseCase),
        dispose: (context, bloc) => bloc.dispose(),
        child: Consumer<MainBloc>(
          builder: (context, bloc, _) => MainScreen(
            userTokens: userTokens,
            mainBloc: bloc,
          ),
        ),
      );

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late StreamSubscription _viewStateStreamSubscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.mainBloc.dispose();
    _viewStateStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: const Color(0xffebe9d7),
      appBar: AppBar(
        backgroundColor: const Color(0xffee4c77),
        title: TextField(
          onChanged: (typedText) {
            _viewStateStreamSubscription = widget.mainBloc
                .getEnterpriseList(typedText, widget.userTokens.accessToken,
                    widget.userTokens.uid, widget.userTokens.client)
                .listen((viewState) {
              widget.mainBloc.mainViewStateInput.add(viewState);
            });
          },
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
              onPressed: () {},
            ),
          ),
        ),
      ),
      body: StreamBuilder<MainViewState>(
        stream: widget.mainBloc.mainViewState,
        initialData: LoadingState(),
        builder: (context, snapshot) => AsyncSnapshotResponseMainView<
            LoadingState,
            GenericErrorState,
            NetworkErrorState,
            NoResult,
            SuccessState,
            InitialState>(
          snapshot: snapshot,
          successWidgetBuilder: (context, successState) {
            final enterpriseList = successState.enterprises;
            return EnterpriseList(
              enterpriseList: enterpriseList,
              userTokens: widget.userTokens,
            );
          },
        ),
      ));
}
