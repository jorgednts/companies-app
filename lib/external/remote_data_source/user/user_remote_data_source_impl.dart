import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ioasys_app/data/remote/user/remote_data_source/user_remote_data_source.dart';
import 'package:ioasys_app/domain/exception/gerenic_error_status_code_exception.dart';
import 'package:ioasys_app/domain/exception/unauthorized_status_code_exception.dart';
import 'package:ioasys_app/domain/model/user/user_model.dart';
import 'package:ioasys_app/domain/model/user/user_tokens.dart';
import 'package:ioasys_app/data/mapper/model_to_remote.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  UserRemoteDataSourceImpl(
    this._dio,
  );

  final Dio _dio;
  static const String _baseUrl = 'https://empresas.ioasys.com.br/api/v1/';

  @override
  Future<UserTokens> doLogin(UserModel userModel) async {
    final userRequest = userModel.toUserRequest();
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
