import 'package:ioasys_app/domain/user/email_status.dart';
import 'package:ioasys_app/domain/user/user_model.dart';

class ValidateEmailUseCase {
  EmailStatus validateEmail(String? email) {
    final emailStatus = UserModel.validateUserEmail(email);
    switch (emailStatus) {
      case EmailStatus.valid:
        return EmailStatus.valid;
      case EmailStatus.invalid:
        return EmailStatus.invalid;
      case EmailStatus.empty:
        return EmailStatus.empty;
    }
  }
}
