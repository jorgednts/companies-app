import 'package:dio/dio.dart';
import 'package:ioasys_app/data/remote/enterprise/model/enterprise/enterprise_list_response.dart';
import 'package:ioasys_app/data/remote/shared/exception/gerenic_error_status_code_exception.dart';
import 'package:ioasys_app/domain/enterprise/enterprise_model.dart';
import 'package:ioasys_app/data/mapper/remote_to_model.dart';

class EnterpriseRemoteDataSource {
  EnterpriseRemoteDataSource(
    this._dio,
  );

  final Dio _dio;
  static const String _baseUrl = 'https://empresas.ioasys.com.br/api/v1/';

  Future<List<EnterpriseModel>> getEnterpriseList(String enterpriseName,
      String accessToken, String uid, String client) async {
    try {
      final response = await _dio.get(
        '${_baseUrl}enterprises',
        queryParameters: {'name': enterpriseName},
        options: Options(
          headers: {
            'access-token': accessToken,
            'client': client,
            'uid': uid,
          },
        ),
      );
      print(response.data);
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
