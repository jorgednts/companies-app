import 'package:ioasys_app/domain/model/user/email_status.dart';
import 'package:ioasys_app/domain/model/user/password_status.dart';
import 'package:ioasys_app/domain/model/user/user_tokens.dart';
import 'package:ioasys_app/domain/use_case/do_login_use_case.dart';
import 'package:ioasys_app/domain/use_case/validate_email_use_case.dart';
import 'package:ioasys_app/domain/use_case/validate_password_use_case.dart';
import 'package:ioasys_app/presentation/login/login_bloc.dart';
import 'package:ioasys_app/presentation/login/login_view_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'login_bloc_test.mocks.dart';

@GenerateMocks([ValidateEmailUseCase, ValidatePasswordUseCase, DoLoginUseCase])
void main() {
  late MockValidateEmailUseCase mockValidateEmailUseCase;
  late MockValidatePasswordUseCase mockValidatePasswordUseCase;
  late MockDoLoginUseCase mockDoLoginUseCase;
  late LoginBloc loginBloc;
  setUpAll(() {
    mockValidateEmailUseCase = MockValidateEmailUseCase();
    mockValidatePasswordUseCase = MockValidatePasswordUseCase();
    mockDoLoginUseCase = MockDoLoginUseCase();
    loginBloc = LoginBloc(mockValidateEmailUseCase, mockValidatePasswordUseCase,
        mockDoLoginUseCase);
  });
  setUp(() {
    reset(mockValidateEmailUseCase);
    reset(mockValidatePasswordUseCase);
    reset(mockDoLoginUseCase);
  });
  group('GIVEN a call on doLogin', () {
    test('WHEN request is successfully THEN it should emits a SuccessState',
        () async {
      when(mockValidateEmailUseCase.validateEmail('testeapple@ioasys.com.br'))
          .thenAnswer((_) => EmailStatus.valid);
      when(mockValidatePasswordUseCase.validatePassword('12341234'))
          .thenAnswer((_) => PasswordStatus.valid);
      when(mockDoLoginUseCase.getFuture(params: anyNamed('params')))
          .thenAnswer((_) async => _getSuccessfulUserTokensMock());
      loginBloc.loginViewState.listen((viewState) {
        expect(loginBloc.loginViewState, emitsInOrder([isA<SuccessState>()]));
      });
    });
  });
}

UserTokens _getSuccessfulUserTokensMock() => const UserTokens(
      '1234',
      '1145',
      '1253',
    );
