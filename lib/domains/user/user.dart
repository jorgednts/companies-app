class User {
  String _userEmail;
  String _userPassword;

  User(this._userEmail, this._userPassword);

  String get userPassword => _userPassword;

  String get userEmail => _userEmail;
}
