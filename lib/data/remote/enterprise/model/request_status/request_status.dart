import 'package:ioasys_app/domain/user/user_tokens.dart';

abstract class RequestStatusAuthLogin {}

class Success implements RequestStatusAuthLogin {
  Success(
    this.userTokens,
  );

  final UserTokens userTokens;
}

class Unauthorized implements RequestStatusAuthLogin{}

class GenericError implements RequestStatusAuthLogin{}

class NetworkError implements RequestStatusAuthLogin{}

enum RequestStatus {
  success,
  unauthorized,
  genericError,
  networkError,
}
