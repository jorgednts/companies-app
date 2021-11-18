import 'package:ioasys_app/domain/repository/user/user_repository.dart';
import 'package:ioasys_app/external/remote/user/user_remote_data_source_impl.dart';
import 'package:ioasys_app/domain/model/user/user_model.dart';
import 'package:ioasys_app/domain/model/user/user_tokens.dart';
import 'package:ioasys_app/data/mapper/model_to_remote.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(
    this.userRemoteDataSource,
  );

  final UserRemoteDataSourceImpl userRemoteDataSource;

  @override
  Future<UserTokens> doLogin(UserModel userModel) async =>
      userRemoteDataSource.doLogin(userModel.toUserRequest());
}
