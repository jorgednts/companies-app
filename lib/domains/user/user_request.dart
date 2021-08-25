class User {
  String _userRequestEmail;
  String _userRequestPassword;

  User(this._userRequestEmail, this._userRequestPassword);

  String get userRequestPassword => _userRequestPassword;

  String get userRequestEmail => _userRequestEmail;
}
