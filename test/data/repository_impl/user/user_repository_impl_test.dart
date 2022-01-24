import 'package:ioasys_app/data/remote/user/remote_data_source/user_remote_data_source.dart';
import 'package:ioasys_app/data/repository_impl/user/user_repository_impl.dart';
import 'package:ioasys_app/domain/model/user/user_model.dart';
import 'package:ioasys_app/domain/model/user/user_tokens.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'user_repository_impl_test.mocks.dart';

@GenerateMocks([UserRemoteDataSource])
void main() {
  late MockUserRemoteDataSource mockUserRemoteDataSource;
  late UserRepositoryImpl userRepositoryImpl;
  setUpAll(() {
    mockUserRemoteDataSource = MockUserRemoteDataSource();
    userRepositoryImpl = UserRepositoryImpl(mockUserRemoteDataSource);
  });
  setUp(() {
    reset(mockUserRemoteDataSource);
  });
  group('GIVEN a call on doLogin', () {
    test(
        'WHEN request is successfully '
        'THEN it should return an UserTokens', () async {
      when(mockUserRemoteDataSource.doLogin(_getSuccessfulUserModelMock()))
          .thenAnswer((_) async => _getSuccessfulUserTokensMock());
      final userTokens =
          await userRepositoryImpl.doLogin(_getSuccessfulUserModelMock());
      expect(userTokens, equals(_getSuccessfulUserTokensMock()));
    });
  });
}

UserModel _getSuccessfulUserModelMock() => const UserModel(
      'testeapple@ioasys.com.br',
      '12341234',
    );

UserTokens _getSuccessfulUserTokensMock() => const UserTokens(
      '1234',
      '1145',
      '1253',
    );
