import 'package:ioasys_app/domain/model/user/user_model.dart';
import 'package:ioasys_app/domain/model/user/user_tokens.dart';

mixin UserRemoteDataSource {
  Future<UserTokens> doLogin(UserModel userModel);
}
