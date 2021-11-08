import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ioasys_app/data/remote/shared/exception/gerenic_error_status_code_exception.dart';
import 'package:ioasys_app/data/remote/shared/exception/unauthorized_status_code_exception.dart';
import 'package:ioasys_app/data/remote/user/model/user/user_request.dart';
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

      if (accessToken != null && uid != null && client != null) {
        return UserTokens(accessToken, client, uid);
      } else {
        throw GenericErrorStatusCodeException();
      }
    } on DioError catch (dioError, _) {
      if (dioError.type == DioErrorType.response) {
        if (dioError.response?.statusCode == HttpStatus.unauthorized) {
          throw UnauthorizedStatusCodeException();
        } else {
          throw GenericErrorStatusCodeException();
        }
      } else {
        throw Exception();
      }
    }
  }
}
