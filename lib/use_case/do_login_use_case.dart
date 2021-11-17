import 'package:ioasys_app/data/repository/user_repository/user_data_repository.dart';
import 'package:ioasys_app/domain/user/user_model.dart';
import 'package:ioasys_app/domain/user/user_tokens.dart';
import 'package:ioasys_app/use_case/use_case.dart';

class DoLoginUseCase extends UseCase<DoLoginUseCaseParams, UserTokens> {
  DoLoginUseCase(
    this.userDataRepository,
  );

  final UserDataRepository userDataRepository;

  @override
  Future<UserTokens> getRawFuture({required DoLoginUseCaseParams params}) =>
      userDataRepository.doLogin(params.userModel);
}

class DoLoginUseCaseParams {
  DoLoginUseCaseParams(
    this.userModel,
  );

  final UserModel userModel;
}
