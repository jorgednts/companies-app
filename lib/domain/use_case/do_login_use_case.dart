import 'package:ioasys_app/domain/model/user/user_model.dart';
import 'package:ioasys_app/domain/model/user/user_tokens.dart';
import 'package:ioasys_app/domain/repository/user/user_repository.dart';
import 'package:ioasys_app/domain/use_case/use_case.dart';

class DoLoginUseCase extends UseCase<DoLoginUseCaseParams, UserTokens> {
  DoLoginUseCase(
    this.userRepository,
  );

  final UserRepository userRepository;

  @override
  Future<UserTokens> getRawFuture({required DoLoginUseCaseParams params}) =>
      userRepository.doLogin(params.userModel);
}

class DoLoginUseCaseParams {
  DoLoginUseCaseParams(
    this.userModel,
  );

  final UserModel userModel;
}
