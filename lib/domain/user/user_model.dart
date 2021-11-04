
import 'package:ioasys_app/domain/user/email_status.dart';

class UserModel {
  UserModel(this.email, this.password);

  final String email;
  final String password;

  static EmailStatus validateUserEmail(String? email) {
    final regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\'
        r'[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.'
        r')+[a-zA-Z]{2,}))$');
    if (email?.isEmpty ?? true) {
      return EmailStatus.empty;
    } else if (!regex.hasMatch(email ?? '')) {
      return EmailStatus.invalid;
    } else {
      return EmailStatus.valid;
    }
  }
}
