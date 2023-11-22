import 'package:fast_jobs/models/users.dart';
import 'package:fast_jobs/ui/pages/home.dart';
import 'package:fast_jobs/ui/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email, _password;
  final _formKey = GlobalKey<FormState>();
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();
  final auth = FirebaseAuth.instance;
  String error_msg = '';
  bool continueConected = true;
  bool isLoginTrue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                width: 400,
                height: 200,
                color: Colors.blue,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 90.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'FastJobs',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w600),
                        ),
                        Image.asset(
                          'assets/fast_icon.png',
                          width: 50,
                          height: 50,
                          color: Colors.white,
                        )
                      ],
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    width: 300,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: email_controller,
                      validator: (value) {
                        if (value!.length < 5) {
                          return "Esse e-mail é inválido.";
                        } else if (!value.contains("@")) {
                          return "Esse e-mail é inválido";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          email = value.trim();
                        });
                      },
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: "E-mail",
                        labelStyle: TextStyle(color: Colors.blue),
                        prefixIcon: Icon(
                          Icons.mail_outline,
                          color: Colors.blue,
                        ),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                  ),
                  Container(
                    width: 300,
                    child: TextFormField(
                      controller: password_controller,
                      validator: (value) {
                        if (value!.length < 6) {
                          return "A Senha deve ter pelo menos 6 caracteres.";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _password = value.trim();
                        });
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Senha",
                        labelStyle: TextStyle(color: Colors.blue),
                        prefixIcon: Icon(
                          Icons.vpn_key_sharp,
                          color: Colors.blue,
                        ),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            isLoginTrue
                ? Text(
                    error_msg,
                    style: TextStyle(color: Colors.red),
                  )
                : const SizedBox(),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(0)),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  setState(() {});
                  _doLogin();
                },
                child: Text(
                  'ENTRAR',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => RegisterPage()));
                },
                child: Text('Não tem uma conta? Cadastre-se'))
          ],
        ),
      ),
    );
  }

  void _doLogin() async {
    setState(() {});
    if (_formKey.currentState!.validate()) {
      _signin(email, _password);
      //Login method will be here

      //Now we have a response from our sqlite method
      //We are going to create a user
    } else {
      print("Inválido");
    }
  }

  _signin(String _email, String _password) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: email_controller.text, password: password_controller.text);
      //sucess
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    } on FirebaseAuthException catch (error) {
      error_msg = error.code;
      isLoginTrue = true;
    }
  }
}
