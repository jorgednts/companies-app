import 'package:ioasys_app/data/repository/user_repository/user_data_repository.dart';
import 'package:ioasys_app/domain/user/user_model.dart';
import 'package:ioasys_app/domain/user/user_tokens.dart';

class DoLoginUseCase {
  DoLoginUseCase(
    this.userDataRepository,
  );

  final UserDataRepository userDataRepository;

  Future<UserTokens> doLogin(UserModel userModel) async =>
      userDataRepository.doLogin(userModel);
}
