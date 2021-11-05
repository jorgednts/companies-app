import 'package:dio/dio.dart';
import 'package:ioasys_app/data/remote/user/model/user_request.dart';

class UserRemoteDataSource {
  UserRemoteDataSource(
    this._dio,
  );

  final Dio _dio;
  static const String _baseUrl = 'https://empresas.ioasys.com.br/api/v1/';

  Future<int> doLogin(UserRequest userRequest) async {
    try {
      final response =
          await _dio.post('${_baseUrl}users/auth/sign_in', data: userRequest);

      print('STATUS CODE:');
      print(response.statusCode);
      print('HEADERS:');
      print(response.headers);

      if(response.statusCode != null) {
        return response.statusCode!;
      } else {
        throw Exception();
      }
    } on DioError{
      throw Exception();
    }
  }
}
