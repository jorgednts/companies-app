/*

EM ANDAMENTO

 */

// import 'dart:async';
//
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:ioasys_app/constants/constants_url_api.dart';
// import 'package:ioasys_app/domain/model/enterprise/enterprise_model.dart';
// import 'package:ioasys_app/domain/model/enterprise/enterprise_type_model.dart';
// import 'package:ioasys_app/domain/model/user/user_tokens.dart';
// import 'package:ioasys_app/generated/l10n.dart';
// import 'package:ioasys_app/presentation/enterprise/enterprise_list/main_bloc.dart';
// import 'package:ioasys_app/presentation/enterprise/enterprise_list/main_screen.dart';
// import 'package:ioasys_app/presentation/enterprise/enterprise_list/main_view_state.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
//
// import 'main_screen_test.mocks.dart';
//
// @GenerateMocks([MainBloc])
// void main() {
//   late MockMainBloc mockMainBloc;
//   setUpAll(() {
//     mockMainBloc = MockMainBloc();
//     S.load(const Locale('pt'));
//   });
//   setUp(() {
//     reset(mockMainBloc);
//   });
//   group('Main Screen', () {
//     testWidgets('it should show loading state', (tester) async {
//       when(mockMainBloc.mainViewState).thenAnswer((_) =>
//           Stream.value(SuccessState(_getSuccessfulEnterpriseListModelMock())));
//       await tester.runAsync(() async {
//         await tester.pumpWidget(_getMainScreenWidget(mockMainBloc));
//         await tester.pump();
//         await tester.pump();
//       });
//       expect(find.byKey(const ValueKey('main-screen-success-state')),
//           findsOneWidget);
//     });
//   });
// }
//
// MaterialApp _getMainScreenWidget(MockMainBloc mockMainBloc) => MaterialApp(
//         home: MainScreen(
//           userTokens: _getSuccessfulUserTokensMock(),
//           mainBloc: mockMainBloc,
//           firebaseAnalytics: FirebaseAnalytics(),
//         ),
//         localizationsDelegates: const [
//           S.delegate,
//           GlobalMaterialLocalizations.delegate,
//           GlobalWidgetsLocalizations.delegate,
//           GlobalCupertinoLocalizations.delegate,
//         ]);
//
// List<EnterpriseModel> _getSuccessfulEnterpriseListModelMock() =>
//     <EnterpriseModel>[
//       const EnterpriseModel(
//         'TeamPlayerHR',
//         '${ConstantsUrlApi.imageBaseUrl}/uploads/enterprise/photo/16/240.jpeg',
//         'description',
//         'UK',
//         EnterpriseTypeModel('HR Tech'),
//         16,
//       ),
//       const EnterpriseModel(
//         'Advanced Diamond X',
//         '${ConstantsUrlApi.imageBaseUrl}/uploads/enterprise/photo/35/240.jpeg',
//         'description',
//         'UK',
//         EnterpriseTypeModel('Industry'),
//         35,
//       ),
//     ];
//
// UserTokens _getSuccessfulUserTokensMock() => const UserTokens(
//       '1234',
//       '1145',
//       '1253',
//     );
