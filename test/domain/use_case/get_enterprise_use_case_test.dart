import 'package:ioasys_app/constants/constants_url_api.dart';
import 'package:ioasys_app/domain/model/enterprise/enterprise_model.dart';
import 'package:ioasys_app/domain/model/enterprise/enterprise_type_model.dart';
import 'package:ioasys_app/domain/repository/enterprise/enterprise_repository.dart';
import 'package:ioasys_app/domain/use_case/get_enterprise_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'get_enterprise_list_use_case_test.mocks.dart';

@GenerateMocks([EnterpriseRepository])
void main() {
  late MockEnterpriseRepository mockEnterpriseRepository;
  late GetEnterpriseUseCase getEnterpriseUseCase;
  setUpAll(() {
    mockEnterpriseRepository = MockEnterpriseRepository();
    getEnterpriseUseCase = GetEnterpriseUseCase(mockEnterpriseRepository);
  });
  setUp(() {
    reset(mockEnterpriseRepository);
  });
  group('GIVEN a call on getRawFuture', () {
    test(
        'WHEN request is successfully '
        'THEN it should return an EnterpriseModel', () async {
      when(mockEnterpriseRepository.getEnterprise(
              4, 'accessToken', 'uid', 'client'))
          .thenAnswer((_) async => _getSuccessfulEnterpriseModelMock());
      final enterprise = await getEnterpriseUseCase.getRawFuture(
          params:
              GetEnterpriseUseCaseParams(4, 'accessToken', 'uid', 'client'));
      expect(enterprise, equals(_getSuccessfulEnterpriseModelMock()));
      verify(mockEnterpriseRepository.getEnterprise(
              4, 'accessToken', 'uid', 'client'))
          .called(1);
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
