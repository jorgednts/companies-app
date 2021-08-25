class UserRequest {
  final String _userRequestEmail;
  final String _userRequestPassword;

  UserRequest(this._userRequestEmail, this._userRequestPassword);

  String get userRequestPassword => _userRequestPassword;

  String get userRequestEmail => _userRequestEmail;
}
