/*

EM ANDAMENTO

 */

// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:ioasys_app/generated/l10n.dart';
// import 'package:ioasys_app/presentation/login/login_bloc.dart';
// import 'package:ioasys_app/presentation/login/login_screen.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
//
// import 'login_screen_test.mocks.dart';
//
// @GenerateMocks([LoginBloc])
// void main() {
//   late MockLoginBloc mockLoginBloc;
//   late LoginScreen loginScreen;
//   setUpAll(() {
//     mockLoginBloc = MockLoginBloc();
//     loginScreen = LoginScreen(loginBloc: mockLoginBloc);
//     S.load(const Locale('pt'));
//   });
//   setUp(() {
//     reset(mockLoginBloc);
//   });
//   group('Login Screen', () {
//     testWidgets('it should show loading state', (tester) async {
//
//     });
//   });
// }
//
// MaterialApp _getLoginScreenWidget(MockLoginBloc mockLoginBloc)
// => MaterialApp(
//         home: LoginScreen(loginBloc: mockLoginBloc),
//         localizationsDelegates: const [
//           S.delegate,
//           GlobalMaterialLocalizations.delegate,
//           GlobalWidgetsLocalizations.delegate,
//           GlobalCupertinoLocalizations.delegate,
//         ]);
