import 'package:ioasys_app/constants/constants_url_api.dart';
import 'package:ioasys_app/domain/model/enterprise/enterprise_model.dart';
import 'package:ioasys_app/domain/model/enterprise/enterprise_type_model.dart';
import 'package:ioasys_app/domain/use_case/get_enterprise_list_use_case.dart';
import 'package:ioasys_app/presentation/enterprise/enterprise_list/main_bloc.dart';
import 'package:ioasys_app/presentation/enterprise/enterprise_list/main_view_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'main_bloc_test.mocks.dart';

@GenerateMocks([GetEnterpriseListUseCase])
void main() {
  late MockGetEnterpriseListUseCase mockGetEnterpriseListUseCase;
  late MainBloc mainBloc;
  setUpAll(() {
    mockGetEnterpriseListUseCase = MockGetEnterpriseListUseCase();
    mainBloc = MainBloc(mockGetEnterpriseListUseCase);
  });
  setUp(() {
    reset(mockGetEnterpriseListUseCase);
  });
  group('GIVEN a call on getEnterpriseList', () {
    test('WHEN request is successfully THEN it should emits a SuccessState',
        () async {
      when(mockGetEnterpriseListUseCase.getFuture(params: anyNamed('params')))
          .thenAnswer((_) async => _getSuccessfulEnterpriseListModelMock());
      mainBloc
          .getEnterpriseList('am', 'accessToken', 'uid', 'client')
          .listen((viewState) {
        expect(
            mainBloc.mainViewState,
            emitsInOrder([
              isA<InitialState>(),
              isA<LoadingState>(),
              isA<SuccessState>(),
            ]));
      });
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
