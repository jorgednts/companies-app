import 'package:ioasys_app/constants/constants_login.dart';
import 'package:ioasys_app/data/remote/shared/exception/gerenic_error_status_code_exception.dart';
import 'package:ioasys_app/data/remote/shared/exception/unauthorized_status_code_exception.dart';
import 'package:ioasys_app/data/remote/shared/view_state/view_state.dart';
import 'package:ioasys_app/data/repository/user_repository/user_data_repository.dart';
import 'package:ioasys_app/domain/user/email_status.dart';
import 'package:ioasys_app/domain/user/password_status.dart';
import 'package:ioasys_app/domain/user/user_model.dart';
import 'package:ioasys_app/extensions/string_extensions.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  LoginBloc(
    this._userDataRepository,
  );

  final UserDataRepository _userDataRepository;

  final _isValidEmail = PublishSubject<EmailStatus>();

  Stream<EmailStatus> get isValidEmail => _isValidEmail.stream;

  final _isValidPassword = PublishSubject<PasswordStatus>();

  Stream<PasswordStatus> get isValidPassword => _isValidPassword.stream;

  final _loading = PublishSubject<bool>();

  Stream<bool> get isLoading => _loading.stream;

  final _loginViewState = PublishSubject<ViewState>();

  Stream<ViewState> get loginViewState => _loginViewState.stream;

  Future<void> doLogin(UserModel userModel) async {
    final isValidateEmail = validateEmail(userModel.email);
    final isValidatePassword = validatePassword(userModel.password);
    if (isValidateEmail == EmailStatus.valid &&
        isValidatePassword == PasswordStatus.valid) {
      _loading.add(true);
      try {
        final userTokens = await _userDataRepository.doLogin(userModel);
        _loading.add(false);
        _loginViewState.add(SuccessState(userTokens));
      } on UnauthorizedStatusCodeException {
        _loading.add(false);
        _loginViewState.add(UnauthorizedErrorState());
      } on GenericErrorStatusCodeException {
        _loading.add(false);
        _loginViewState.add(GenericErrorState());
      } catch (e) {
        _loading.add(false);
        _loginViewState.add(NetworkErrorState());
      }
    }
  }

  EmailStatus validateEmail(String? email) {
    final emailStatus = UserModel.validateUserEmail(email);
    switch (emailStatus) {
      case EmailStatus.valid:
        _isValidEmail.add(EmailStatus.valid);
        return EmailStatus.valid;
      case EmailStatus.invalid:
        _isValidEmail.add(EmailStatus.invalid);
        return EmailStatus.invalid;
      case EmailStatus.empty:
        _isValidEmail.add(EmailStatus.empty);
        return EmailStatus.empty;
    }
  }

  PasswordStatus validatePassword(String? password) {
    if (password == null || password.isBlank()) {
      _isValidPassword.add(PasswordStatus.empty);
      return PasswordStatus.empty;
    } else {
      if (password.length < ConstantsLogin.minimumPasswordLength) {
        _isValidPassword.add(PasswordStatus.invalid);
        return PasswordStatus.invalid;
      } else {
        _isValidPassword.add(PasswordStatus.valid);
        return PasswordStatus.valid;
      }
    }
  }

  void dispose() {
    _isValidEmail.close();
    _isValidPassword.close();
    _loading.close();
    _loginViewState.close();
  }
}
