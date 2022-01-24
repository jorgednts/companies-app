import 'package:dio/dio.dart';
import 'package:ioasys_app/constants/constants_url_api.dart';
import 'package:ioasys_app/domain/exception/unauthorized_status_code_exception.dart';
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
  setUpAll(() {
    mockDio = MockDio();
    userRemoteDataSourceImpl = UserRemoteDataSourceImpl(mockDio);
  });
  setUp(() {
    reset(mockDio);
  });
  group('GIVEN a call on doLogin', () {
    const doLoginSuccessResponsePath =
        'test_resources/do_login_success_response.json';
    const doLoginFailResponsePath =
        'test_resources/do_login_fail_response.json';
    test('THEN verify if correct url is called', () async {
      final json = await doLoginSuccessResponsePath.getJsonFromPath();
      when(mockDio.post(any, data: anyNamed('data'))).thenAnswer(
        (_) async => _getSuccessfulResponseMock(json),
      );
      await userRemoteDataSourceImpl.doLogin(_getSuccessfulUserModelMock());
      verify(mockDio.post('${ConstantsUrlApi.baseUrl}users/auth/sign_in',
              data: anyNamed('data')))
          .called(1);
    });

    test(
        'WHEN request is successfully '
        'THEN it should return an UserTokens', () async {
      final json = await doLoginSuccessResponsePath.getJsonFromPath();
      when(mockDio.post(
        any,
        data: anyNamed('data'),
      )).thenAnswer(
        (_) async => _getSuccessfulResponseMock(json),
      );
      final userTokens =
          await userRemoteDataSourceImpl.doLogin(_getSuccessfulUserModelMock());
      final userTokensExpected = _getSuccessfulUserTokensMock();
      expect(userTokens, equals(userTokensExpected));
    });
    test(
        'WHEN code response equals 401 '
        'THEN it should return a UnauthorizedStatusCodeException', () async {
      final json = await doLoginFailResponsePath.getJsonFromPath();
      when(mockDio.post(
        any,
        data: anyNamed('data'),
      )).thenThrow(
        _getErrorResponseMock(json),
      );
      try {
        await userRemoteDataSourceImpl.doLogin(_getErrorUserModelMock());
      } catch (e) {
        expect(e, isA<UnauthorizedStatusCodeException>());
      }
    });
  });
}

DioError _getErrorResponseMock(json) => DioError(
      response: Response(
        data: json,
        statusCode: 401,
        requestOptions: RequestOptions(
          path: '',
        ),
      ),
      type: DioErrorType.response,
      requestOptions: RequestOptions(path: ''),
    );

Response<dynamic> _getSuccessfulResponseMock(json) => Response(
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

UserTokens _getSuccessfulUserTokensMock() => const UserTokens(
      '1234',
      '1145',
      '1253',
    );

UserModel _getSuccessfulUserModelMock() => const UserModel(
      'testeapple@ioasys.com.br',
      '12341234',
    );

UserModel _getErrorUserModelMock() => const UserModel(
      'testeapple@ioasys.com.br',
      '12341235',
    );
