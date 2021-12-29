import 'package:dio/dio.dart';
import 'package:ioasys_app/data/remote/user/model/user/user_request.dart';
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
  const doLoginSuccessResponse =
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
      final json = await doLoginSuccessResponse.getJsonFromPath();
      when(mockDio.post(any, data: _getUserRequestMock)).thenAnswer(
        (_) async => _getResponseMock(json),
      );
      await userRemoteDataSourceImpl.doLogin(_getUserModelMock());
      verify(mockDio.post('${baseUrl}users/auth/sign_in',
              data: _getUserRequestMock))
          .called(1);
    });
  });
}

UserTokens _getUserTokensMock() => UserTokens('access-token', 'client', 'uid');

Response<dynamic> _getResponseMock(json) => Response(
      data: json,
      statusCode: 200,
      requestOptions: RequestOptions(path: ''),
    );

UserModel _getUserModelMock() =>
    UserModel('testeapple@ioasys.com.br', '12341234');

UserRequest _getUserRequestMock() =>
    UserRequest('testeapple@ioasys.com.br', '12341234');
