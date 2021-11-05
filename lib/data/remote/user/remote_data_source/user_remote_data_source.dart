import 'package:dio/dio.dart';
import 'package:ioasys_app/data/remote/enterprise/model/exception/gerenic_error_status_code_exception.dart';
import 'package:ioasys_app/data/remote/enterprise/model/exception/unauthorized_status_code_exception.dart';
import 'package:ioasys_app/data/remote/user/model/user_request.dart';
import 'package:ioasys_app/domain/user/user_tokens.dart';

class UserRemoteDataSource {
  UserRemoteDataSource(
    this._dio,
  );

  final Dio _dio;
  static const String _baseUrl = 'https://empresas.ioasys.com.br/api/v1/';

  Future<UserTokens> doLogin(UserRequest userRequest) async {
    try {
      final response =
          await _dio.post('${_baseUrl}users/auth/sign_in', data: userRequest);

      final accessToken = response.headers.value('access-token');
      final uid = response.headers.value('uid');
      final client = response.headers.value('client');

      if (response.statusCode == 200) {
        if (accessToken != null && uid != null && client != null) {
          return UserTokens(accessToken, uid, client);
        } else {
          throw GenericErrorStatusCodeException();
        }
      } else if (response.statusCode == 401) {
        throw UnauthorizedStatusCodeException();
      } else {
        throw GenericErrorStatusCodeException();
      }
    } on DioError {
      throw Exception();
    }
  }
}
