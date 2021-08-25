import 'package:ioasys_app/domains/user/email_status.dart';

class User {
  String _userEmail;
  String _userPassword;

  User(this._userEmail, this._userPassword);

  String get userPassword => _userPassword;

  String get userEmail => _userEmail;

  EmailStatus validateUserEmail(String email) {
    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\'
        r'[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.'
        r')+[a-zA-Z]{2,}))$');
    if (!regex.hasMatch(email))
      return EmailStatus.INVALID;
    else if (email.isEmpty)
      return EmailStatus.EMPTY;
    else
      return EmailStatus.VALID;
  }
}
