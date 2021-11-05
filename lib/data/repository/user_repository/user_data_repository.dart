
import 'package:ioasys_app/domain/user/user_model.dart';
import 'package:ioasys_app/domain/user/user_tokens.dart';

mixin UserDataRepository {
  Future<UserTokens> doLogin(UserModel userModel);
}