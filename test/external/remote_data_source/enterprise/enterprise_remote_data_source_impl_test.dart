import 'package:dio/dio.dart';
import 'package:ioasys_app/external/remote_data_source/enterprise/enterprise_remote_data_source_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'enterprise_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late EnterpriseRemoteDataSourceImpl enterpriseRemoteDataSourceImpl;
  const baseUrl = 'https://empresas.ioasys.com.br/api/v1/';
  setUpAll(() {
    mockDio = MockDio();
    enterpriseRemoteDataSourceImpl = EnterpriseRemoteDataSourceImpl(mockDio);
  });
  setUp(() {
    reset(mockDio);
  });
  group('given a call on getEnterpriseList', () {
    test('then verify if base url is called', () async {});
  });
  group('given a call on getEnterprise', () {});
}
