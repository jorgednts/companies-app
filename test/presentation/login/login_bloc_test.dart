import 'package:ioasys_app/domain/use_case/do_login_use_case.dart';
import 'package:ioasys_app/domain/use_case/validate_email_use_case.dart';
import 'package:ioasys_app/domain/use_case/validate_password_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

@GenerateMocks([ValidateEmailUseCase, ValidatePasswordUseCase, DoLoginUseCase])
void main() {}
