import 'package:ioasys_app/data/remote/shared/exception/gerenic_error_status_code_exception.dart';
import 'package:ioasys_app/data/remote/shared/view_state/main_view_state.dart';
import 'package:ioasys_app/data/repository/enterprise_repository/enterprise_data_repository.dart';
import 'package:rxdart/rxdart.dart';

class MainBloc {
  MainBloc(
    this._enterpriseDataRepository,
  );

  final EnterpriseDataRepository _enterpriseDataRepository;

  final _loading = PublishSubject<bool>();

  Stream<bool> get isLoading => _loading.stream;

  final _mainViewState = PublishSubject<MainViewState>();

  Stream<MainViewState> get mainViewState => _mainViewState.stream;

  Future<void> getEnterpriseList(String enterpriseName, String accessToken,
      String uid, String client) async {
    _loading.add(true);
    try {
      final enterpriseList = await _enterpriseDataRepository.getEnterpriseList(
          enterpriseName, accessToken, uid, client);
      _loading.add(false);
      _mainViewState.add(SuccessState(enterpriseList));
    } on GenericErrorStatusCodeException {
      _loading.add(false);
      _mainViewState.add(GenericErrorState());
    } catch (e) {
      _loading.add(false);
      _mainViewState.add(NetworkErrorState());
    }
  }

  void dispose() {
    _loading.close();
    _mainViewState.close();
  }
}
