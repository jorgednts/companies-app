import 'package:ioasys_app/data/remote/user/model/user/user_request.dart';
import 'package:ioasys_app/domain/model/user/user_tokens.dart';

mixin UserRemoteDataSource {
  Future<UserTokens> doLogin(UserRequest userRequest);
}
