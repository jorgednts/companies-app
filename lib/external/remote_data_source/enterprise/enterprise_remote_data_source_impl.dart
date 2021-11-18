import 'package:dio/dio.dart';
import 'package:ioasys_app/constants/constants_user_tokens.dart';
import 'package:ioasys_app/data/remote/enterprise/model/enterprise/enterprise_list_response.dart';
import 'package:ioasys_app/data/remote/enterprise/model/enterprise/enterprises_response.dart';
import 'package:ioasys_app/data/remote/enterprise/remote_data_source/enterprise_remote_data_source.dart';
import 'package:ioasys_app/domain/exception/gerenic_error_status_code_exception.dart';
import 'package:ioasys_app/domain/model/enterprise/enterprise_model.dart';
import 'package:ioasys_app/data/mapper/remote_to_model.dart';

class EnterpriseRemoteDataSourceImpl implements EnterpriseRemoteDataSource {
  EnterpriseRemoteDataSourceImpl(
    this._dio,
  );

  final Dio _dio;
  static const String _baseUrl =
      'https://empresas.ioasys.com.br/api/v1/enterprises/';

  @override
  Future<List<EnterpriseModel>> getEnterpriseList(String enterpriseName,
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
      return EnterpriseListResponse.fromJson(response.data)
          .toEnterpriseListModel();
    } on DioError catch (dioError, _) {
      if (dioError.type == DioErrorType.response) {
        throw GenericErrorStatusCodeException();
      } else {
        throw Exception();
      }
    }
  }

  @override
  Future<EnterpriseModel> getEnterprise(
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
      return EnterprisesResponse.fromJson(response.data).toEnterpriseModel();
    } on DioError catch (dioError, _) {
      if (dioError.type == DioErrorType.response) {
        throw GenericErrorStatusCodeException();
      } else {
        throw Exception();
      }
    }
  }
}
