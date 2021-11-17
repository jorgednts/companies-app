import 'package:ioasys_app/constants/constants_login.dart';
import 'package:ioasys_app/domain/user/password_status.dart';
import 'package:ioasys_app/extensions/string_extensions.dart';

class ValidatePasswordUseCase {
  PasswordStatus validatePassword(String? password) {
    if (password == null || password.isBlank()) {
      return PasswordStatus.empty;
    } else {
      if (password.length < ConstantsLogin.minimumPasswordLength) {
        return PasswordStatus.invalid;
      } else {
        return PasswordStatus.valid;
      }
    }
  }
}
