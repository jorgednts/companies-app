import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ioasys_app/bloc/login_bloc/login_bloc.dart';
import 'package:ioasys_app/constants/constants_images.dart';
import 'package:ioasys_app/data/remote/shared/view_state/login_view_state.dart';
import 'package:ioasys_app/domain/user/email_status.dart';
import 'package:ioasys_app/domain/user/password_status.dart';
import 'package:ioasys_app/domain/user/user_model.dart';
import 'package:ioasys_app/generated/l10n.dart';
import 'package:ioasys_app/use_case/do_login_use_case.dart';
import 'package:ioasys_app/use_case/validate_email_use_case.dart';
import 'package:ioasys_app/use_case/validate_password_use_case.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    required this.loginBloc,
    Key? key,
  }) : super(key: key);
  final LoginBloc loginBloc;

  static Widget create(BuildContext context) => ProxyProvider3<
          ValidateEmailUseCase,
          ValidatePasswordUseCase,
          DoLoginUseCase,
          LoginBloc>(
        update: (context, validateEmailUseCase, validatePasswordUseCase,
                doLoginUseCase, bloc) =>
            bloc ??
            LoginBloc(
              validateEmailUseCase,
              validatePasswordUseCase,
              doLoginUseCase,
            ),
        dispose: (context, bloc) => bloc.dispose(),
        child: Consumer<LoginBloc>(
          builder: (context, bloc, _) => LoginScreen(
            loginBloc: bloc,
          ),
        ),
      );

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userEmailInputController =
      TextEditingController();
  final TextEditingController _userPasswordInputController =
      TextEditingController();
  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();
  late StreamSubscription _viewStateStreamSubscription;
  late StreamSubscription _isLoadingStreamSubscription;

  @override
  void initState() {
    super.initState();
    _setupStreams();
  }

  @override
  void dispose() {
    widget.loginBloc.dispose();
    _viewStateStreamSubscription.cancel();
    _isLoadingStreamSubscription.cancel();
    super.dispose();
  }

  void _showAlertDialog(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(S.of(context).messageAlertTitle),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(S.of(context).alertDialogButton),
                ),
              ],
            ));
  }

  void _setupStreams() {
    _setupStreamViewState();
    _setupStreamIsLoading();
  }

  void _setupStreamIsLoading() {
    _isLoadingStreamSubscription =
        widget.loginBloc.isLoading.listen((isLoading) {
      if (isLoading) {
        showDialog(
            context: context,
            builder: (context) => const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                    backgroundColor: Colors.transparent,
                  ),
                ));
      } else {
        Navigator.pop(context);
      }
    });
  }

  void _setupStreamViewState() {
    _viewStateStreamSubscription =
        widget.loginBloc.loginViewState.listen((viewState) {
      if (viewState is SuccessState) {
        Navigator.of(context)
            .pushNamed('main-screen', arguments: viewState.userTokens);
      } else if (viewState is NetworkErrorState) {
        _showAlertDialog(S.of(context).messageNetworkError);
      } else if (viewState is UnauthorizedErrorState) {
        _showAlertDialog(S.of(context).messageUnauthorizedAuth);
      } else {
        _showAlertDialog(S.of(context).messageGenericError);
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xffebe9d7),
        body: SizedBox.expand(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 90,
                ),
                Image.asset(
                  ConstantsImages.imageLogo,
                  width: 160,
                  height: 50,
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Text(
                    S.of(context).loginScreenWelcomeText.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Text(
                    S.of(context).loginScreenIntroductionText,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Form(
                    key: _formKeyEmail,
                    child: TextFormField(
                      controller: _userEmailInputController,
                      validator: (typedEmail) {
                        final emailStatus =
                            widget.loginBloc.validateEmail(typedEmail);
                        if (emailStatus == EmailStatus.invalid) {
                          return S.of(context).loginScreenFormInvalidEmail;
                        } else if (emailStatus == EmailStatus.empty) {
                          return S.of(context).loginScreenEmptyFormText;
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: S.of(context).loginScreenFormEmailLabelText,
                        labelStyle: const TextStyle(color: Colors.grey),
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Color(0xffee4c77),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Form(
                    key: _formKeyPassword,
                    child: TextFormField(
                      controller: _userPasswordInputController,
                      validator: (typedPassword) {
                        final passwordStatus =
                            widget.loginBloc.validatePassword(typedPassword);
                        switch (passwordStatus) {
                          case PasswordStatus.valid:
                            return null;
                          case PasswordStatus.invalid:
                            return S.of(context).loginScreenFormInvalidPassword;
                          case PasswordStatus.empty:
                            return S.of(context).loginScreenEmptyFormText;
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText:
                            S.of(context).loginScreenFormPasswordLabelText,
                        labelStyle: const TextStyle(color: Colors.grey),
                        prefixIcon: const Icon(
                          Icons.password,
                          color: Color(0xffee4c77),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      final isValidEmail =
                          _formKeyEmail.currentState?.validate() ?? false;
                      final isValidPassword =
                          _formKeyPassword.currentState?.validate() ?? false;
                      if (isValidEmail && isValidPassword) {
                        final userModel = UserModel(
                            _userEmailInputController.text.toString(),
                            _userPasswordInputController.text.toString());
                        widget.loginBloc.doLogin(userModel);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff57bbbc),
                    ),
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        S.of(context).loginScreenButtonText.toUpperCase(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );

  void _setupStreamViewState() {
    _loginBloc.loginViewState.listen((viewState) {
      if (viewState is SuccessState) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MainScreen(userTokens: viewState.userTokens)));
      } else if (viewState is NetworkErrorState) {
        _showAlertDialog(S.of(context).messageNetworkError);
      } else if (viewState is UnauthorizedErrorState) {
        _showAlertDialog(S.of(context).messageUnauthorizedAuth);
      } else {
        _showAlertDialog(S.of(context).messageGenericError);
      }
    });
  }

  void _setupStreamIsLoading() {
    _loginBloc.isLoading.listen((isLoading) {
      if (isLoading) {
        showDialog(
            context: context,
            builder: (context) => const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                    backgroundColor: Colors.transparent,
                  ),
                ));
      } else {
        Navigator.pop(context);
      }
    });
  }

  void _showAlertDialog(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(S.of(context).alertDialogTitle),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(S.of(context).alertDialogButton),
                ),
              ],
            ));
  }
}
