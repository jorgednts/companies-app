import 'package:dio/dio.dart';
import 'package:ioasys_app/constants/constants_url_api.dart';
import 'package:ioasys_app/domain/model/enterprise/enterprise_model.dart';
import 'package:ioasys_app/domain/model/enterprise/enterprise_type_model.dart';
import 'package:ioasys_app/external/remote_data_source/enterprise/enterprise_remote_data_source_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../../utils/json_extensions.dart';
import 'enterprise_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late EnterpriseRemoteDataSourceImpl enterpriseRemoteDataSourceImpl;
  setUpAll(() {
    mockDio = MockDio();
    enterpriseRemoteDataSourceImpl = EnterpriseRemoteDataSourceImpl(mockDio);
  });
  setUp(() {
    reset(mockDio);
  });
  group('GIVEN a call on getEnterpriseList', () {
    const getEnterpriseListSuccessResponsePath =
        'test_resources/get_enterprise_list_success_response.json';
    test('THEN verify if correct url is called', () async {
      final json = await getEnterpriseListSuccessResponsePath.getJsonFromPath();
      when(mockDio.get(
        any,
        queryParameters: anyNamed('queryParameters'),
        options: anyNamed('options'),
      )).thenAnswer(
        (_) async => _getSuccessfulResponseMock(json),
      );
      await enterpriseRemoteDataSourceImpl.getEnterpriseList(
          'am', 'accessToken', 'uid', 'client');
      verify(mockDio.get(
        '${ConstantsUrlApi.baseUrl}/enterprises/',
        queryParameters: anyNamed('queryParameters'),
        options: anyNamed('options'),
      )).called(1);
    });
    test(
        'WHEN request is successfully '
        'THEN it should return an EnterpriseListModel', () async {
      final json = await getEnterpriseListSuccessResponsePath.getJsonFromPath();
      when(mockDio.get(
        any,
        queryParameters: anyNamed('queryParameters'),
        options: anyNamed('options'),
      )).thenAnswer(
        (_) async => _getSuccessfulResponseMock(json),
      );
      final enterpriseListModel = await enterpriseRemoteDataSourceImpl
          .getEnterpriseList('am', 'accessToken', 'uid', 'client');
      final enterpriseListModelExpected = _getSuccessfulEnterpriseListModel();
      expect(enterpriseListModel, enterpriseListModelExpected);
    });
  });
  group('GIVEN a call on getEnterprise', () {});
}

List<EnterpriseModel> _getSuccessfulEnterpriseListModel() => <EnterpriseModel>[
      const EnterpriseModel(
          'TeamPlayerHR',
          '${ConstantsUrlApi.imageBaseUrl}/uploads/enterprise/photo/16/240.jpeg',
          'description',
          'UK',
          EnterpriseTypeModel('HR Tech'),
          16),
      const EnterpriseModel(
          'Advanced Diamond X',
          '${ConstantsUrlApi.imageBaseUrl}/uploads/enterprise/photo/35/240.jpeg',
          'description',
          'UK',
          EnterpriseTypeModel('Industry'),
          35),
    ];

Response<dynamic> _getSuccessfulResponseMock(json) => Response(
      data: json,
      statusCode: 200,
      requestOptions: RequestOptions(path: ''),
    );
