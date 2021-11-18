import 'package:ioasys_app/domain/model/user/user_model.dart';
import 'package:ioasys_app/domain/model/user/user_tokens.dart';

mixin UserRepository {
  Future<UserTokens> doLogin(UserModel userModel);
}
