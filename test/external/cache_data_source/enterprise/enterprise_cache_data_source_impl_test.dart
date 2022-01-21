/*

EM ANDAMENTO

*/

// import 'package:hive/hive.dart';
// import 'package:ioasys_app/constants/constants_url_api.dart';
// import 'package:ioasys_app/data/cache/enterprise/model/enterprise_cm.dart';
// import 'package:ioasys_app/data/cache/enterprise/model/enterprise_type_cm.dart';
// import 'package:ioasys_app/domain/model/enterprise/enterprise_model.dart';
// import 'package:ioasys_app/domain/model/enterprise/enterprise_type_model.dart';
// import 'package:ioasys_app/external/cache_data_source/enterprise/enterprise_cache_data_source_impl.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:test/test.dart';
//
// import 'enterprise_cache_data_source_impl_test.mocks.dart';
//
// @GenerateMocks([HiveInterface, Box])
// void main() {
//   late MockHiveInterface mockHiveInterface;
//   late MockBox mockBox;
//   late EnterpriseCacheDataSourceImpl enterpriseCacheDataSourceImpl;
//   setUpAll(() {
//     mockHiveInterface = MockHiveInterface();
//     mockBox = MockBox();
//     enterpriseCacheDataSourceImpl =
//         EnterpriseCacheDataSourceImpl(mockHiveInterface);
//   });
//   setUp(() {
//     reset(mockHiveInterface);
//   });
//   group('GIVEN a call on getEnterprise', () {
//     const movieId = 4;
//     test('THEN verify if openBox is called', () async {
//       when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockBox);
//       when(mockBox.get(any))
//           .thenAnswer((_) async => _getSuccessfulEnterpriseCMMock());
//       await enterpriseCacheDataSourceImpl.getEnterprise(movieId);
//       verify(mockHiveInterface.openBox(anyNamed('openBox')));
//       verify(mockBox.get(anyNamed('get')));
//     });
//     test(
//         'WHEN request is successfully '
//         'THEN it should return an EnterpriseModel', () async {
//       when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockBox);
//       when(mockBox.get(any))
//           .thenAnswer((_) async => _getSuccessfulEnterpriseCMMock());
//       final enterpriseModel =
//           await enterpriseCacheDataSourceImpl.getEnterprise(movieId);
//       final enterpriseModelExpected = _getSuccessfulEnterpriseModelMock();
//       expect(enterpriseModel, enterpriseModelExpected);
//     });
//   });
//   group('GIVEN a call on saveEnterprise', () {
//     test('THEN verify if openBox is called', () async {
//       when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockBox);
//       await enterpriseCacheDataSourceImpl
//           .saveEnterprise(_getEnterpriseModelMock());
//       verify(mockHiveInterface.openBox(anyNamed('openBox')));
//       verify(mockBox.put(any, any));
//     });
//   });
// }
//
// EnterpriseModel _getEnterpriseModelMock() => const EnterpriseModel(
//       'VendorLink',
//       '${ConstantsUrlApi.imageBaseUrl}/uploads/enterprise/photo/4/240.jpeg',
//       'description',
//       'UK',
//       EnterpriseTypeModel('IT'),
//       4,
//     );
//
// EnterpriseModel _getSuccessfulEnterpriseModelMock() => const EnterpriseModel(
//       'VendorLink',
//       '${ConstantsUrlApi.imageBaseUrl}/uploads/enterprise/photo/4/240.jpeg',
//       'description',
//       'UK',
//       EnterpriseTypeModel('IT'),
//       4,
//     );
//
// EnterpriseCM? _getSuccessfulEnterpriseCMMock() => EnterpriseCM(
//       'VendorLink',
//       '${ConstantsUrlApi.imageBaseUrl}/uploads/enterprise/photo/4/240.jpeg',
//       'description',
//       'UK',
//       EnterpriseTypeCM('IT'),
//       4,
//     );
