import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ioasys_app/bloc/async_snapshot_response_view/async_snapshot_response_result_view.dart';
import 'package:ioasys_app/bloc/result_bloc/result_bloc.dart';
import 'package:ioasys_app/data/remote/shared/view_state/result_view_state.dart';
import 'package:ioasys_app/data/repository/enterprise_repository/enterprise_data_repository.dart';
import 'package:ioasys_app/domain/user/user_tokens.dart';
import 'package:ioasys_app/view/result_view/widgets/enterprise.dart';
import 'package:provider/provider.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    required this.enterpriseId,
    required this.userTokens,
    required this.resultBloc,
    Key? key,
  }) : super(key: key);
  final int enterpriseId;
  final UserTokens userTokens;
  final ResultBloc resultBloc;

  static Widget create(
          BuildContext context, int enterpriseId, UserTokens userTokens) =>
      ProxyProvider<EnterpriseDataRepository, ResultBloc>(
        update: (context, repository, bloc) => bloc ?? ResultBloc(repository),
        dispose: (context, bloc) => bloc.dispose(),
        child: Consumer<ResultBloc>(
          builder: (context, bloc, _) => ResultScreen(
            enterpriseId: enterpriseId,
            userTokens: userTokens,
            resultBloc: bloc,
          ),
        ),
      );

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late StreamSubscription _viewStateStreamSubscription;

  @override
  void initState() {
    super.initState();
    _viewStateStreamSubscription = widget.resultBloc
        .getEnterprise(widget.enterpriseId, widget.userTokens.accessToken,
            widget.userTokens.uid, widget.userTokens.client)
        .listen((viewState) {
      widget.resultBloc.resultViewStateInput.add(viewState);
    });
  }

  @override
  void dispose() {
    widget.resultBloc.dispose();
    _viewStateStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<ResultViewState>(
        stream: widget.resultBloc.resultViewState,
        initialData: LoadingState(),
        builder: (context, snapshot) => AsyncSnapshotResponseResultView<
            LoadingState, GenericErrorState, NetworkErrorState, SuccessState>(
          snapshot: snapshot,
          successWidgetBuilder: (context, successState) {
            final enterprise = successState.enterprise;
            return Enterprise(
              enterprise: enterprise,
            );
          },
        ),
      );
}
