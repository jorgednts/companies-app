import 'package:ioasys_app/domain/model/user/password_status.dart';
import 'package:ioasys_app/extensions/string_extensions.dart';

class ValidatePasswordUseCase {
  final minimumPasswordLength = 8;

  PasswordStatus validatePassword(String? password) {
    if (password == null || password.isBlank()) {
      return PasswordStatus.empty;
    } else {
      if (password.length < minimumPasswordLength) {
        return PasswordStatus.invalid;
      } else {
        return PasswordStatus.valid;
      }
    }
  }
}
