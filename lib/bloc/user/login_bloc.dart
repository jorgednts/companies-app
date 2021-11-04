import 'package:ioasys_app/data/repository/user_repository/user_data_repository.dart';

class LoginBloc {
  LoginBloc(
    this._userDataRepository,
  );
  final UserDataRepository _userDataRepository;

  final _publishSubject = PublishSubject<bool>();

}
