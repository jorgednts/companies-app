import 'package:ioasys_app/data/remote/shared/exception/gerenic_error_status_code_exception.dart';
import 'package:ioasys_app/data/remote/shared/view_state/main_view_state.dart';
import 'package:ioasys_app/domain/use_case/get_enterprise_list_use_case.dart';
import 'package:rxdart/rxdart.dart';

class MainBloc {
  MainBloc(
    this.getEnterpriseListUseCase,
  );

  final GetEnterpriseListUseCase getEnterpriseListUseCase;

  final _mainViewState = BehaviorSubject<MainViewState>.seeded(InitialState());

  Stream<MainViewState> get mainViewState => _mainViewState.stream;

  Sink<MainViewState> get mainViewStateInput => _mainViewState.sink;

  Stream<MainViewState> getEnterpriseList(String enterpriseName,
      String accessToken, String uid, String client) async* {
    try {
      final enterpriseList = await getEnterpriseListUseCase.getFuture(
          params: GetEnterpriseListUseCaseParams(
              enterpriseName, accessToken, uid, client));
      yield LoadingState();
      if (enterpriseList.isNotEmpty) {
        yield SuccessState(enterpriseList);
      } else {
        yield NoResult();
      }
    } on GenericErrorStatusCodeException {
      yield GenericErrorState();
    } catch (e) {
      yield NetworkErrorState();
    }
  }

  void dispose() {
    _mainViewState.close();
  }
}
