import 'package:ioasys_app/data/repository/user_repository/user_data_repository.dart';
import 'package:ioasys_app/domain/user/email_status.dart';
import 'package:ioasys_app/domain/user/password_status.dart';
import 'package:ioasys_app/domain/user/user_model.dart';
import 'package:ioasys_app/domain/user/user_tokens.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ioasys_app/extensions/string_extensions.dart';

class LoginBloc {
  LoginBloc(
    this._userDataRepository,
  );

  final UserDataRepository _userDataRepository;

  final _isValidEmailPublishSubject = PublishSubject<EmailStatus>();

  Stream<EmailStatus> get isValidEmail => _isValidEmailPublishSubject.stream;

  final _isValidPasswordPublishSubject = PublishSubject<PasswordStatus>();

  Stream<PasswordStatus> get isValidPassword =>
      _isValidPasswordPublishSubject.stream;

  final _loadingPublishSubject = PublishSubject<bool>();

  Stream<bool> get isLoading => _loadingPublishSubject.stream;

  final _userTokensPublishSubject = PublishSubject<UserTokens>();

  Stream<UserTokens> get userTokens => _userTokensPublishSubject.stream;

  final _authorizedLoginPublishSubject = PublishSubject<bool>();

  Stream<bool> get authorizedLogin =>
      _authorizedLoginPublishSubject.stream;

  Future<void> doLogin(UserModel userModel) async {
    _authorizedLoginPublishSubject.add(false);
    _loadingPublishSubject.add(true);
    final isValidateEmail = validateEmail(userModel.email);
    final isValidatePassword = validatePassword(userModel.password);
    if (isValidateEmail == EmailStatus.valid &&
        isValidatePassword == PasswordStatus.valid) {
      try {
        final status = await _userDataRepository.doLogin(userModel);
        if(status == 200){
          _authorizedLoginPublishSubject.add(true);
        } else {
          _authorizedLoginPublishSubject.add(false);
        }
      } catch (e) {
        throw Exception();
      }
    }
  }

  EmailStatus validateEmail(String? email) {
    final emailStatus = UserModel.validateUserEmail(email);
    switch (emailStatus) {
      case EmailStatus.valid:
        _isValidEmailPublishSubject.add(EmailStatus.valid);
        return EmailStatus.valid;
      case EmailStatus.invalid:
        _isValidEmailPublishSubject.add(EmailStatus.invalid);
        return EmailStatus.invalid;
      case EmailStatus.empty:
        _isValidEmailPublishSubject.add(EmailStatus.empty);
        return EmailStatus.empty;
    }
  }

  PasswordStatus validatePassword(String? password) {
    if(password == null || password.isBlank()){
      _isValidPasswordPublishSubject.add(PasswordStatus.empty);
      return PasswordStatus.empty;
    } else {
      if (password.length < 8) {
        _isValidPasswordPublishSubject.add(PasswordStatus.invalid);
        return PasswordStatus.invalid;
      } else {
        _isValidPasswordPublishSubject.add(PasswordStatus.valid);
        return PasswordStatus.valid;
      }
    }
  }

  void dispose() {
    _isValidEmailPublishSubject.close();
    _isValidPasswordPublishSubject.close();
    _loadingPublishSubject.close();
    _userTokensPublishSubject.close();
    _authorizedLoginPublishSubject.close();
  }
}
