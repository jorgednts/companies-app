import 'package:flutter/material.dart';
import 'package:ioasys_app/presentation/enterprise/empty_enterprise_list.dart';
import 'package:ioasys_app/generated/l10n.dart';

class AsyncSnapshotResponseMainView<Loading, GenericError, NetworkError,
    NoResult, Success, Initial> extends StatelessWidget {
  AsyncSnapshotResponseMainView({
    required this.successWidgetBuilder,
    required this.snapshot,
    Key? key,
  })  : assert(Loading != dynamic),
        assert(GenericError != dynamic),
        assert(NetworkError != dynamic),
        assert(NoResult != dynamic),
        assert(Success != dynamic),
        assert(Initial != dynamic),
        super(key: key);

  final AsyncSnapshot snapshot;
  final Widget Function(BuildContext context, Success success)
      successWidgetBuilder;

  @override
  Widget build(BuildContext context) {
    final snapshotData = snapshot.data;
    if (snapshotData == null || snapshotData is Loading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
          backgroundColor: Colors.white,
        ),
      );
    }

    if (snapshotData is Initial) {
      return EmptyEnterpriseList(
          message: S.of(context).mainScreenInitialStateMessage);
    }

    if (snapshotData is NoResult) {
      return EmptyEnterpriseList(
          message: S.of(context).mainScreenNoEnterpriseResult);
    }

    if (snapshotData is GenericError) {
      return EmptyEnterpriseList(message: S.of(context).messageGenericError);
    }

    if (snapshotData is NetworkError) {
      return EmptyEnterpriseList(message: S.of(context).messageNetworkError);
    }

    if (snapshotData is Success) {
      return successWidgetBuilder(context, snapshotData);
    }
    throw UnknownStateTypeException();
  }
}

class UnknownStateTypeException implements Exception {}
