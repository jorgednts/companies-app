
import 'package:ioasys_app/domain/user/email_status.dart';

class UserModel {
  String _userEmail;
  String _userPassword;

  UserModel(this._userEmail, this._userPassword);

  String get userPassword => _userPassword;

  String get userEmail => _userEmail;

  static EmailStatus validateUserEmail(String? email) {
    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\'
        r'[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.'
        r')+[a-zA-Z]{2,}))$');
    if (email?.isEmpty ?? true)
      return EmailStatus.EMPTY;
    else if (!regex.hasMatch(email ?? ''))
      return EmailStatus.INVALID;
    else
      return EmailStatus.VALID;
  }
}
