import 'package:ioasys_app/domain/model/user/password_status.dart';
import 'package:ioasys_app/domain/use_case/validate_password_use_case.dart';
import 'package:test/test.dart';

void main() {
  late ValidatePasswordUseCase validatePasswordUseCase;
  setUpAll(() {
    validatePasswordUseCase = ValidatePasswordUseCase();
  });
  group('GIVEN a call on validatePassword', () {
    test('WHEN password is blank THEN it should return an PasswordStatus.empty',
        () async {
      final passwordStatus = validatePasswordUseCase.validatePassword('');
      expect(passwordStatus, PasswordStatus.empty);
    });
    test('WHEN password is null THEN it should return an PasswordStatus.empty',
        () async {
      final passwordStatus = validatePasswordUseCase.validatePassword(null);
      expect(passwordStatus, PasswordStatus.empty);
    });
    test(
        'WHEN password is invalid (password length < minimumPasswordLength) '
        'THEN it should return '
        'an PasswordStatus.invalid', () async {
      final passwordStatus = validatePasswordUseCase.validatePassword('1234');
      expect(passwordStatus, PasswordStatus.invalid);
    });
    test(
        'WHEN password is valid (password length >= minimumPasswordLength)THEN '
        'it should return an PasswordStatus.valid', () async {
      final passwordStatus =
          validatePasswordUseCase.validatePassword('12345678');
      expect(passwordStatus, PasswordStatus.valid);
    });
  });
}
