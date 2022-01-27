import 'package:ioasys_app/constants/constants_url_api.dart';
import 'package:ioasys_app/data/cache/enterprise/cache_data_source/enterprise_cache_data_source.dart';
import 'package:ioasys_app/data/remote/enterprise/remote_data_source/enterprise_remote_data_source.dart';
import 'package:ioasys_app/data/repository_impl/enterprise/enterprise_repository_impl.dart';
import 'package:ioasys_app/domain/model/enterprise/enterprise_model.dart';
import 'package:ioasys_app/domain/model/enterprise/enterprise_type_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'enterprise_repository_impl_test.mocks.dart';

@GenerateMocks([EnterpriseRemoteDataSource, EnterpriseCacheDataSource])
void main() {
  late MockEnterpriseCacheDataSource mockEnterpriseCacheDataSource;
  late MockEnterpriseRemoteDataSource mockEnterpriseRemoteDataSource;
  late EnterpriseRepositoryImpl enterpriseRepositoryImpl;
  setUpAll(() {
    mockEnterpriseCacheDataSource = MockEnterpriseCacheDataSource();
    mockEnterpriseRemoteDataSource = MockEnterpriseRemoteDataSource();
    enterpriseRepositoryImpl = EnterpriseRepositoryImpl(
        mockEnterpriseRemoteDataSource, mockEnterpriseCacheDataSource);
  });
  setUp(() {
    reset(mockEnterpriseCacheDataSource);
    reset(mockEnterpriseCacheDataSource);
  });
  group('GIVEN a call on getEnterpriseList', () {
    test(
        'WHEN request is successfully '
        'THEN it should return an EnterpriseModel list', () async {
      when(mockEnterpriseRemoteDataSource.getEnterpriseList(
              'am', 'accessToken', 'uid', 'client'))
          .thenAnswer((_) async => _getSuccessfulEnterpriseListModelMock());
      final enterpriseList = await enterpriseRepositoryImpl.getEnterpriseList(
          'am', 'accessToken', 'uid', 'client');
      expect(enterpriseList, equals(_getSuccessfulEnterpriseListModelMock()));
      verify(mockEnterpriseRemoteDataSource.getEnterpriseList(
              'am', 'accessToken', 'uid', 'client'))
          .called(1);
    });
    test(
        'WHEN request is fail '
        'THEN it should throw an exception', () async {
      when(mockEnterpriseRemoteDataSource.getEnterpriseList(
              'am', 'accessToken', 'uid', 'client'))
          .thenThrow(Exception());
      expect(
          () => enterpriseRepositoryImpl.getEnterpriseList(
              'am', 'accessToken', 'uid', 'client'),
          throwsException);
    });
  });
  group('GIVEN a call on getEnterprise', () {
    test(
        'WHEN request is successfully '
        'THEN it should return an EnterpriseModel', () async {
      when(mockEnterpriseRemoteDataSource.getEnterprise(
              4, 'accessToken', 'uid', 'client'))
          .thenAnswer((_) async => _getSuccessfulEnterpriseModelMock());
      when(mockEnterpriseCacheDataSource
              .saveEnterprise(_getSuccessfulEnterpriseModelMock()))
          .thenAnswer((_) async => Null);
      when(mockEnterpriseCacheDataSource.getEnterprise(4))
          .thenAnswer((_) async => _getSuccessfulEnterpriseModelMock());
      final enterprise = await enterpriseRepositoryImpl.getEnterprise(
          4, 'accessToken', 'uid', 'client');
      expect(enterprise, _getSuccessfulEnterpriseModelMock());
      verify(mockEnterpriseRemoteDataSource.getEnterpriseList(
          'am', 'accessToken', 'uid', 'client'));
      verify(mockEnterpriseCacheDataSource
          .saveEnterprise(_getSuccessfulEnterpriseModelMock()));
      verify(mockEnterpriseCacheDataSource.getEnterprise(4));
    });
    test(
        'WHEN request is fail '
        'THEN it should return an Enterprise Cache', () async {
      when(mockEnterpriseRemoteDataSource.getEnterprise(
              4, 'accessToken', 'uid', 'client'))
          .thenThrow(Exception());
      when(mockEnterpriseCacheDataSource
              .saveEnterprise(_getSuccessfulEnterpriseModelMock()))
          .thenAnswer((_) async => Null);
      when(mockEnterpriseCacheDataSource.getEnterprise(4))
          .thenAnswer((_) async => _getSuccessfulEnterpriseModelMock());
      final enterprise = await enterpriseRepositoryImpl.getEnterprise(
          4, 'accessToken', 'uid', 'client');
      expect(enterprise, _getSuccessfulEnterpriseModelMock());
    });
  });
}

EnterpriseModel _getSuccessfulEnterpriseModelMock() => const EnterpriseModel(
      'VendorLink',
      '${ConstantsUrlApi.imageBaseUrl}/uploads/enterprise/photo/4/240.jpeg',
      'description',
      'UK',
      EnterpriseTypeModel('IT'),
      4,
    );

List<EnterpriseModel> _getSuccessfulEnterpriseListModelMock() =>
    <EnterpriseModel>[
      const EnterpriseModel(
        'TeamPlayerHR',
        '${ConstantsUrlApi.imageBaseUrl}/uploads/enterprise/photo/16/240.jpeg',
        'description',
        'UK',
        EnterpriseTypeModel('HR Tech'),
        16,
      ),
      const EnterpriseModel(
        'Advanced Diamond X',
        '${ConstantsUrlApi.imageBaseUrl}/uploads/enterprise/photo/35/240.jpeg',
        'description',
        'UK',
        EnterpriseTypeModel('Industry'),
        35,
      ),
    ];
