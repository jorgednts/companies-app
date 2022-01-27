import 'package:ioasys_app/constants/constants_url_api.dart';
import 'package:ioasys_app/domain/model/enterprise/enterprise_model.dart';
import 'package:ioasys_app/domain/model/enterprise/enterprise_type_model.dart';
import 'package:ioasys_app/domain/use_case/get_enterprise_use_case.dart';
import 'package:ioasys_app/presentation/enterprise/enterprise_details/result_bloc.dart';
import 'package:ioasys_app/presentation/enterprise/enterprise_details/result_view_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'result_bloc_test.mocks.dart';

@GenerateMocks([GetEnterpriseUseCase])
void main() {
  late MockGetEnterpriseUseCase mockGetEnterpriseUseCase;
  late ResultBloc resultBloc;
  setUpAll(() {
    mockGetEnterpriseUseCase = MockGetEnterpriseUseCase();
    resultBloc = ResultBloc(mockGetEnterpriseUseCase);
  });
  setUp(() {
    reset(mockGetEnterpriseUseCase);
  });
  group('GIVEN a call on getEnterprise', () {
    test('WHEN request is successfully THEN it should emits a SuccessState',
        () async {
      when(mockGetEnterpriseUseCase.getFuture(params: anyNamed('params')))
          .thenAnswer((_) async => _getSuccessfulEnterpriseModelMock());
      resultBloc
          .getEnterprise(4, 'accessToken', 'uid', 'client')
          .listen((viewState) {
        expect(
            resultBloc.resultViewState,
            emitsInOrder([
              isA<LoadingState>(),
              isA<LoadingState>(),
              isA<SuccessState>(),
            ]));
      });
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
