import 'package:ioasys_app/domain/model/user/user_model.dart';
import 'package:ioasys_app/domain/model/user/user_tokens.dart';
import 'package:ioasys_app/domain/repository/user/user_repository.dart';
import 'package:ioasys_app/domain/use_case/do_login_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'do_login_use_case_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  late MockUserRepository mockUserRepository;
  late DoLoginUseCase doLoginUseCase;
  setUpAll(() {
    mockUserRepository = MockUserRepository();
    doLoginUseCase = DoLoginUseCase(mockUserRepository);
  });
  setUp(() {
    reset(mockUserRepository);
  });
  group('GIVEN a call on getRawFuture', () {
    test(
        'WHEN request is successfully '
        'THEN it should return an UserTokens', () async {
      when(mockUserRepository.doLogin(_getSuccessfulUserModelMock()))
          .thenAnswer((_) async => _getSuccessfulUserTokensMock());
      final userTokens = await doLoginUseCase.getRawFuture(
          params: DoLoginUseCaseParams(_getSuccessfulUserModelMock()));
      expect(userTokens, equals(_getSuccessfulUserTokensMock()));
      verify(mockUserRepository.doLogin(_getSuccessfulUserModelMock()))
          .called(1);
    });
  });
}

UserTokens _getSuccessfulUserTokensMock() => const UserTokens(
      '1234',
      '1145',
      '1253',
    );

UserModel _getSuccessfulUserModelMock() => const UserModel(
      'testeapple@ioasys.com.br',
      '12341234',
    );
