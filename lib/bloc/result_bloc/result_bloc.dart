import 'package:ioasys_app/data/remote/shared/exception/gerenic_error_status_code_exception.dart';
import 'package:ioasys_app/data/remote/shared/view_state/result_view_state.dart';
import 'package:ioasys_app/data/repository/enterprise_repository/enterprise_data_repository.dart';
import 'package:rxdart/rxdart.dart';

class ResultBloc {
  ResultBloc(
    this._enterpriseDataRepository,
  );

  final EnterpriseDataRepository _enterpriseDataRepository;

  final _resultViewState =
      BehaviorSubject<ResultViewState>.seeded(LoadingState());

  Stream<ResultViewState> get resultViewState => _resultViewState.stream;

  Sink<ResultViewState> get resultViewStateInput => _resultViewState.sink;

  Stream<ResultViewState> getEnterprise(
      int id, String accessToken, String uid, String client) async* {
    yield LoadingState();
    try {
      final enterprise = await _enterpriseDataRepository.getEnterprise(
          id, accessToken, uid, client);
      yield SuccessState(enterprise);
    } on GenericErrorStatusCodeException {
      yield GenericErrorState();
    } catch (e) {
      yield NetworkErrorState();
    }
  }

  void dispose() {
    _resultViewState.close();
  }
}
