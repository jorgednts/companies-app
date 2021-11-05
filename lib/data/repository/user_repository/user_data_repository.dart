
import 'package:ioasys_app/domain/user/user_model.dart';

mixin UserDataRepository {
  Future<int> doLogin(UserModel userModel);
}