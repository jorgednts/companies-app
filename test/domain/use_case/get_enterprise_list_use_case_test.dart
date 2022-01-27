import 'package:ioasys_app/constants/constants_url_api.dart';
import 'package:ioasys_app/domain/model/enterprise/enterprise_model.dart';
import 'package:ioasys_app/domain/model/enterprise/enterprise_type_model.dart';
import 'package:ioasys_app/domain/repository/enterprise/enterprise_repository.dart';
import 'package:ioasys_app/domain/use_case/get_enterprise_list_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'get_enterprise_list_use_case_test.mocks.dart';

@GenerateMocks([EnterpriseRepository])
void main() {
  late MockEnterpriseRepository mockEnterpriseRepository;
  late GetEnterpriseListUseCase getEnterpriseListUseCase;
  setUpAll(() {
    mockEnterpriseRepository = MockEnterpriseRepository();
    getEnterpriseListUseCase =
        GetEnterpriseListUseCase(mockEnterpriseRepository);
  });
  setUp(() {
    reset(mockEnterpriseRepository);
  });
  group('GIVEN a call on getRawFuture', () {
    test(
        'WHEN request is successfully '
        'THEN it should return an EnterpriseModel list', () async {
      when(mockEnterpriseRepository.getEnterpriseList(
              'am', 'accessToken', 'uid', 'client'))
          .thenAnswer((_) async => _getSuccessfulEnterpriseListModelMock());
      final enterpriseList = await getEnterpriseListUseCase.getRawFuture(
          params: GetEnterpriseListUseCaseParams(
              'am', 'accessToken', 'uid', 'client'));
      expect(enterpriseList, equals(_getSuccessfulEnterpriseListModelMock()));
      verify(mockEnterpriseRepository.getEnterpriseList(
          'am', 'accessToken', 'uid', 'client'));
    });
  });
}

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
