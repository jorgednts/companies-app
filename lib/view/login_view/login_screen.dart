import 'package:flutter/material.dart';
import 'package:ioasys_app/constants/constants_images.dart';
import 'package:ioasys_app/domain/user/email_status.dart';
import 'package:ioasys_app/domain/user/user_model.dart';
import 'package:ioasys_app/generated/l10n.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _userEmailInputController = TextEditingController();
  TextEditingController _userPasswordInputController = TextEditingController();
  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffebe9d7),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SizedBox(
            child: Container(
                child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Image.asset(
                  ConstantsImages.imageLogo,
                  width: 160,
                  height: 50,
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Text(
                    S.of(context).loginScreenWelcomeText.toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Text(
                    S.of(context).loginScreenIntroductionText,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Form(
                    key: _formKeyEmail,
                    child: TextFormField(
                      controller: _userEmailInputController,
                      validator: (userEmail) {
                        if (UserModel.validateUserEmail(userEmail) ==
                            EmailStatus.INVALID) {
                          return S.of(context).loginScreenFormInvalidEmail;
                        } else if (UserModel.validateUserEmail(userEmail) ==
                            EmailStatus.EMPTY) {
                          return S.of(context).loginScreenEmptyFormText;
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: S.of(context).loginScreenFormEmailLabelText,
                        labelStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Color(0xffee4c77),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Form(
                    key: _formKeyPassword,
                    child: TextFormField(
                      controller: _userPasswordInputController,
                      validator: (userPassword) {
                        if (userPassword == null) {
                          return S.of(context).loginScreenEmptyFormText;
                        } else if (userPassword.length < 8) {
                          return S.of(context).loginScreenFormInvalidPassword;
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText:
                            S.of(context).loginScreenFormPasswordLabelText,
                        labelStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(
                          Icons.password,
                          color: Color(0xffee4c77),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      _formKeyEmail.currentState!.validate();
                      _formKeyPassword.currentState!.validate();
                      Navigator.of(context).pushReplacementNamed('/main');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff57bbbc),
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
                SizedBox(
                  height: 20,
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
