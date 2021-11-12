import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ioasys_app/bloc/async_snapshot_response_view/async_snapshot_response_result_view.dart';
import 'package:ioasys_app/bloc/result_bloc/result_bloc.dart';
import 'package:ioasys_app/data/cache_model/enterprise/cache_data_source/enterprise_cache_data_source.dart';
import 'package:ioasys_app/data/remote/enterprise/remote_data_source/enterprise_remote_data_source.dart';
import 'package:ioasys_app/data/remote/shared/view_state/result_view_state.dart';
import 'package:ioasys_app/data/repository/enterprise_repository/enterprise_data_repository.dart';
import 'package:ioasys_app/data/repository/enterprise_repository/enterprise_repository.dart';
import 'package:ioasys_app/domain/user/user_tokens.dart';
import 'package:ioasys_app/view/result_view/widgets/enterprise.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    required this.enterpriseId,
    required this.userTokens,
    Key? key,
  }) : super(key: key);
  final int enterpriseId;
  final UserTokens userTokens;

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late EnterpriseRemoteDataSource _enterpriseRemoteDataSource;
  late EnterpriseCacheDataSource _enterpriseCacheDataSource;
  late EnterpriseDataRepository _enterpriseDataRepository;
  late ResultBloc _resultBloc;
  late StreamSubscription _viewStateStreamSubscription;

  @override
  void initState() {
    super.initState();
    _enterpriseRemoteDataSource = EnterpriseRemoteDataSource(Dio());
    _enterpriseCacheDataSource = EnterpriseCacheDataSource();
    _enterpriseDataRepository = EnterpriseRepository(
        _enterpriseRemoteDataSource, _enterpriseCacheDataSource);
    _resultBloc = ResultBloc(_enterpriseDataRepository);
    _viewStateStreamSubscription = _resultBloc
        .getEnterprise(widget.enterpriseId, widget.userTokens.accessToken,
            widget.userTokens.uid, widget.userTokens.client)
        .listen((viewState) {
      _resultBloc.resultViewStateInput.add(viewState);
    });
  }

  @override
  void dispose() {
    _resultBloc.dispose();
    _viewStateStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<ResultViewState>(
        stream: _resultBloc.resultViewState,
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
