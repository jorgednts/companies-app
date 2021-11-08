import 'package:dio/dio.dart';
import 'package:ioasys_app/data/remote/enterprise/model/enterprise/enterprise_list_response.dart';
import 'package:ioasys_app/data/remote/shared/exception/gerenic_error_status_code_exception.dart';

class EnterpriseRemoteDataSource {
  EnterpriseRemoteDataSource(
    this._dio,
  );

  final Dio _dio;
  static const String _baseUrl = 'https://empresas.ioasys.com.br/api/v1/';

  Future<EnterpriseListResponse> getEnterpriseList(String enterpriseName,
      String accessToken, String uid, String client) async {
    try {
      final response =
          await _dio.get('${_baseUrl}enterprises?name=$enterpriseName',
              queryParameters: {'name': enterpriseName},
              options: Options(
                headers: {
                  'access-token': accessToken,
                  'client': client,
                  'uid': uid,
                },
              ));
      return EnterpriseListResponse.fromJson(response.data);
    } on DioError catch (dioError, _) {
      if (dioError.type == DioErrorType.response) {
        throw GenericErrorStatusCodeException();
      } else {
        throw Exception();
      }
    }
  }
}
