import 'package:flutter/material.dart';
import 'package:ioasys_app/domains/user/email_status.dart';
import 'package:ioasys_app/domains/user/user.dart';


class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _userEmailInputController = TextEditingController();
  TextEditingController _userPasswordInputController = TextEditingController();
  late String _emailVerification;
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
                  'assets/images/logo.png',
                  width: 160,
                  height: 50,
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Text(
                    'BEM VINDO AO \n EMPRESAS',
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
                    'Lorem ipsum dolor sit amet, contetur adipiscing elit. Nunc accumsan.',
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
                        if (User.validateUserEmail(userEmail) ==
                            EmailStatus.INVALID) {
                          _emailVerification =
                              'Digite um email válido. Ex: abc@abc.com.br';
                          return _emailVerification;
                        } else if (User.validateUserEmail(userEmail) ==
                            EmailStatus.EMPTY) {
                          _emailVerification = 'Preencha o campo';
                          return _emailVerification;
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'E-mail',
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
                          return 'Preencha o campo';
                        } else if (userPassword.length < 8) {
                          return 'A senha deve conter pelo menos 8 caracteres';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Senha',
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
                        'ENTRAR',
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
