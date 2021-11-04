

import 'package:ioasys_app/data/remote/user/remote_data_source/user_remote_data_source.dart';
import 'package:ioasys_app/data/repository/user_repository/user_data_repository.dart';
import 'package:ioasys_app/domain/user/user_model.dart';
import 'package:ioasys_app/domain/user/user_tokens.dart';
import 'package:ioasys_app/data/mapper/model_to_remote.dart';

class UserRepository implements UserDataRepository {
  UserRepository(this._userRemoteDataSource);
  final UserRemoteDataSource _userRemoteDataSource;

  @override
  Future<UserTokens> doLogin(UserModel userModel) async {
    final userRequest = userModel.toUserRequest();
    final userTokens = await _userRemoteDataSource.doLogin(userRequest);
    return userTokens;
  }
}