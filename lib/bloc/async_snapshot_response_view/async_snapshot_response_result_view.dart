import 'package:flutter/material.dart';
import 'package:ioasys_app/generated/l10n.dart';

class AsyncSnapshotResponseResultView<Loading, GenericError, NetworkError,
    Success> extends StatelessWidget {
  AsyncSnapshotResponseResultView({
    required this.successWidgetBuilder,
    required this.snapshot,
    Key? key,
  })  : assert(Loading != dynamic),
        assert(GenericError != dynamic),
        assert(NetworkError != dynamic),
        assert(Success != dynamic),
        super(key: key);

  final AsyncSnapshot snapshot;
  final Widget Function(BuildContext context, Success success)
      successWidgetBuilder;

  @override
  Widget build(BuildContext context) {
    final snapshotData = snapshot.data;
    if (snapshotData == null || snapshotData is Loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).loadingAppBarTitle),
          backgroundColor: const Color(0xffee4c77),
        ),
        body: const Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
            backgroundColor: Colors.white,
          ),
        ),
      );
    }

    if (snapshotData is GenericError) {
      return Scaffold(
          appBar: AppBar(
            title: Text(S.of(context).messageAlertTitle),
            backgroundColor: const Color(0xffee4c77),
          ),
          body: Center(
            child: Text(S.of(context).messageGenericError),
          ));
    }

    if (snapshotData is NetworkError) {
      return Scaffold(
          appBar: AppBar(
            title: Text(S.of(context).messageAlertTitle),
            backgroundColor: const Color(0xffee4c77),
          ),
          body: Center(
            child: Text(S.of(context).messageNetworkError),
          ));
    }

    if (snapshotData is Success) {
      return successWidgetBuilder(context, snapshotData);
    }
    throw UnknownStateTypeException();
  }
}

class UnknownStateTypeException implements Exception {}
