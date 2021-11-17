import 'package:ioasys_app/domain/model/user/email_status.dart';

class ValidateEmailUseCase {
  final regex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\'
      r'[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.'
      r')+[a-zA-Z]{2,}))$');

  EmailStatus validateEmail(String? email) {
    if (email?.isEmpty ?? true) {
      return EmailStatus.empty;
    } else if (!regex.hasMatch(email ?? '')) {
      return EmailStatus.invalid;
    } else {
      return EmailStatus.valid;
    }
  }
}
