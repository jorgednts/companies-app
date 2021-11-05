import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ioasys_app/bloc/user/login_bloc.dart';
import 'package:ioasys_app/constants/constants_images.dart';
import 'package:ioasys_app/data/remote/enterprise/model/request_status/request_status.dart';
import 'package:ioasys_app/data/remote/user/remote_data_source/user_remote_data_source.dart';
import 'package:ioasys_app/data/repository/user_repository/user_data_repository.dart';
import 'package:ioasys_app/data/repository/user_repository/user_repository.dart';
import 'package:ioasys_app/domain/user/email_status.dart';
import 'package:ioasys_app/domain/user/password_status.dart';
import 'package:ioasys_app/domain/user/user_model.dart';
import 'package:ioasys_app/domain/user/user_tokens.dart';
import 'package:ioasys_app/generated/l10n.dart';
import 'package:ioasys_app/view/main_view/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
  late UserRemoteDataSource _userRemoteDataSource;
  late UserDataRepository _userDataRepository;
  late LoginBloc _loginBloc;
  late UserTokens _userTokens;

  @override
  void initState() {
    super.initState();
    _userRemoteDataSource = UserRemoteDataSource(Dio());
    _userDataRepository = UserRepository(_userRemoteDataSource);
    _loginBloc = LoginBloc(_userDataRepository);
    _setupStream();
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  void _setupStream() {
    _loginBloc.requestLoginResponse.listen((event) {
      if (event == RequestStatus.success) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MainScreen(userTokens: _userTokens)),
        );
      }
    });
    _loginBloc.userTokens.listen((event) {
      _userTokens = event;
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
                  height: 30,
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
                            _loginBloc.validateEmail(typedEmail);
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
                            _loginBloc.validatePassword(typedPassword);
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
                        _loginBloc.doLogin(userModel);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff57bbbc),
                    ),
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        S.of(context).loginScreenButtonText,
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
}
