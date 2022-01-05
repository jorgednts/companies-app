import 'package:dio/dio.dart';
import 'package:ioasys_app/domain/model/user/user_model.dart';
import 'package:ioasys_app/domain/model/user/user_tokens.dart';
import 'package:ioasys_app/external/remote_data_source/user/user_remote_data_source_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../../utils/json_extensions.dart';
import 'user_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late UserRemoteDataSourceImpl userRemoteDataSourceImpl;
  const baseUrl = 'https://empresas.ioasys.com.br/api/v1/';
  const doLoginSuccessResponsePath =
      'test_resources/do_login_success_response.json';
  setUpAll(() {
    mockDio = MockDio();
    userRemoteDataSourceImpl = UserRemoteDataSourceImpl(mockDio);
  });
  setUp(() {
    reset(mockDio);
  });
  group('doLogin', () {
    test('verify if base url is called', () async {
      final json = await doLoginSuccessResponsePath.getJsonFromPath();
      when(mockDio.post(any, data: anyNamed('data'))).thenAnswer(
        (_) async => _getResponseMock(json),
      );
      await userRemoteDataSourceImpl.doLogin(_getUserModelMock());
      verify(mockDio.post('${baseUrl}users/auth/sign_in',
              data: anyNamed('data')))
          .called(1);
    });

    test('it should return an UserTokens', () async {
      final json = await doLoginSuccessResponsePath.getJsonFromPath();
      when(mockDio.post(
        any,
        data: anyNamed('data'),
      )).thenAnswer(
        (_) async => _getResponseMock(json),
      );
      final userTokens =
          await userRemoteDataSourceImpl.doLogin(_getUserModelMock());
      final userTokensExpected = _getUserTokensMock();
      expect(userTokens, equals(userTokensExpected));
    });
  });
}

Response<dynamic> _getResponseMock(json) => Response(
      data: json,
      statusCode: 200,
      requestOptions: RequestOptions(
        path: '',
      ),
      headers: Headers.fromMap({
        'access-token': ['1234'],
        'client': ['1145'],
        'uid': ['1253']
      }),
    );

UserTokens _getUserTokensMock() => const UserTokens(
      '1234',
      '1145',
      '1253',
    );

UserModel _getUserModelMock() => UserModel(
      'testeapple@ioasys.com.br',
      '12341234',
    );
