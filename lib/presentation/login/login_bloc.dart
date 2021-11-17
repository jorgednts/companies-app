import 'package:ioasys_app/domain/exception/gerenic_error_status_code_exception.dart';
import 'package:ioasys_app/domain/exception/unauthorized_status_code_exception.dart';
import 'package:ioasys_app/presentation/login/login_view_state.dart';
import 'package:ioasys_app/domain/model/user/email_status.dart';
import 'package:ioasys_app/domain/model/user/password_status.dart';
import 'package:ioasys_app/domain/model/user/user_model.dart';
import 'package:ioasys_app/domain/use_case/do_login_use_case.dart';
import 'package:ioasys_app/domain/use_case/validate_email_use_case.dart';
import 'package:ioasys_app/domain/use_case/validate_password_use_case.dart';

import 'package:rxdart/rxdart.dart';

class LoginBloc {
  LoginBloc(
    this.validateEmailUseCase,
    this.validatePasswordUseCase,
    this.doLoginUseCase,
  );

  final ValidateEmailUseCase validateEmailUseCase;
  final ValidatePasswordUseCase validatePasswordUseCase;
  final DoLoginUseCase doLoginUseCase;

  final _isValidEmail = PublishSubject<EmailStatus>();

  Stream<EmailStatus> get isValidEmail => _isValidEmail.stream;

  final _isValidPassword = PublishSubject<PasswordStatus>();

  Stream<PasswordStatus> get isValidPassword => _isValidPassword.stream;

  final _loading = PublishSubject<bool>();

  Stream<bool> get isLoading => _loading.stream;

  final _loginViewState = PublishSubject<LoginViewState>();

  Stream<LoginViewState> get loginViewState => _loginViewState.stream;

  Future<void> doLogin(UserModel userModel) async {
    final isValidateEmail = validateEmail(userModel.email);
    final isValidatePassword = validatePassword(userModel.password);
    if (isValidateEmail == EmailStatus.valid &&
        isValidatePassword == PasswordStatus.valid) {
      _loading.add(true);
      try {
        final userTokens = await doLoginUseCase.getFuture(
            params: DoLoginUseCaseParams(userModel));
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

  void dispose() {
    _isValidEmail.close();
    _isValidPassword.close();
    _loading.close();
    _loginViewState.close();
  }

  EmailStatus validateEmail(String? email) {
    final isValidateEmail = validateEmailUseCase.validateEmail(email);
    switch (isValidateEmail) {
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
    final isValidatePassword =
        validatePasswordUseCase.validatePassword(password);
    switch (isValidatePassword) {
      case PasswordStatus.valid:
        _isValidPassword.add(PasswordStatus.valid);
        return PasswordStatus.valid;
      case PasswordStatus.invalid:
        _isValidPassword.add(PasswordStatus.invalid);
        return PasswordStatus.invalid;
      case PasswordStatus.empty:
        _isValidPassword.add(PasswordStatus.empty);
        return PasswordStatus.empty;
    }
  }
}
