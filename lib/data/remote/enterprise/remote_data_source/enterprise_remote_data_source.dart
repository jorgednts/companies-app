import 'package:dio/dio.dart';
import 'package:ioasys_app/constants/constants_user_tokens.dart';
import 'package:ioasys_app/data/remote/enterprise/model/enterprise/enterprise_list_response.dart';
import 'package:ioasys_app/data/remote/enterprise/model/enterprise/enterprises_response.dart';
import 'package:ioasys_app/data/remote/shared/exception/gerenic_error_status_code_exception.dart';

class EnterpriseRemoteDataSource {
  EnterpriseRemoteDataSource(
    this._dio,
  );

  final Dio _dio;
  static const String _baseUrl =
      'https://empresas.ioasys.com.br/api/v1/enterprises/';

  Future<EnterpriseListResponse> getEnterpriseList(String enterpriseName,
      String accessToken, String uid, String client) async {
    try {
      final response = await _dio.get(
        '$_baseUrl',
        queryParameters: {'name': enterpriseName},
        options: Options(
          headers: {
            ConstantsUserTokens.accessToken: accessToken,
            ConstantsUserTokens.client: client,
            ConstantsUserTokens.uid: uid,
          },
        ),
      );
      return EnterpriseListResponse.fromJson(response.data);
    } on DioError catch (dioError, _) {
      if (dioError.type == DioErrorType.response) {
        throw GenericErrorStatusCodeException();
      } else {
        throw Exception();
      }
    }
  }

  Future<EnterprisesResponse> getEnterprise(
      int id, String accessToken, String uid, String client) async {
    try {
      final response = await _dio.get(
        '$_baseUrl$id',
        options: Options(
          headers: {
            ConstantsUserTokens.accessToken: accessToken,
            ConstantsUserTokens.client: client,
            ConstantsUserTokens.uid: uid,
          },
        ),
      );
      return EnterprisesResponse.fromJson(response.data);
    } on DioError catch (dioError, _) {
      if (dioError.type == DioErrorType.response) {
        throw GenericErrorStatusCodeException();
      } else {
        throw Exception();
      }
    }
  }
}
