import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_jobs/models/users.dart';
import 'package:fast_jobs/ui/pages/home.dart';
import 'package:fast_jobs/ui/pages/login.dart';
import 'package:fast_jobs/ui/pages/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String email, _password, nome;
  final auth = FirebaseAuth.instance;
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();
  final name_controller = TextEditingController();
  final data_controller = TextEditingController();
  final job_controller = TextEditingController();
  String error_msg = '';
  bool isLoginTrue = false;

  final formKey = GlobalKey<FormState>();

  bool showPassword = false;

  final _formKey = GlobalKey<FormState>();
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
              padding: const EdgeInsets.only(top: 50.0),
            ),
            Text(
              'Cadastre-se',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    width: 300,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: name_controller,
                      validator: (value) {
                        if (value!.length < 5) {
                          return "Digite seu nome completo.";
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
                        labelText: "Nome completo",
                        labelStyle: TextStyle(color: Colors.blue),
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
                      keyboardType: TextInputType.emailAddress,
                      controller: job_controller,
                      validator: (value) {
                        if (value!.length < 5) {
                          return "Digite o cargo pretendido.";
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
                        labelText: "Cargo Pretendido",
                        labelStyle: TextStyle(color: Colors.blue),
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
                      keyboardType: TextInputType.emailAddress,
                      controller: data_controller,
                      validator: (value) {
                        if (value!.length < 8) {
                          return "Digite sua data de nascimento.";
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
                        labelText: "Data de nascimento",
                        labelStyle: TextStyle(color: Colors.blue),
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
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                  ),
                  Container(
                    width: 300,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.length < 6) {
                          return "As senhas devem ser iguais.";
                        } else if (value != _password) {
                          return "A Senha deve ter pelo menos 6 caracteres.";
                        }
                        return null;
                      },
                      obscureText: (this.showPassword == true) ? false : true,
                      decoration: InputDecoration(
                        labelText: "Repita a Senha",
                        labelStyle: TextStyle(color: Colors.blue),
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
              padding: const EdgeInsets.only(top: 15.0),
            ),
            isLoginTrue
                ? Text(
                    error_msg,
                    style: TextStyle(color: Colors.red),
                  )
                : const SizedBox(),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(0)),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  _doSignup();
                },
                child: Text(
                  'CADASTRAR',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => LoginPage()));
                },
                child: Text('Tem uma conta? Faça Login')),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
            ),
          ],
        ),
      ),
    );
  }

  void _doSignup() async {
    setState(() {});
    if (_formKey.currentState!.validate()) {
      return _signup(email_controller.text, password_controller.text);
    }
  }

  _signup(String _email, String _password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email_controller.text, password: password_controller.text);
      createUser();
      //sucess
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()));
    } on FirebaseAuthException catch (error) {
      error_msg = error.code;
      isLoginTrue = true;
    }
  }

  Future createUser() async {
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc(email_controller.text);
    final user = User(
      id: email_controller.text,
      nome: name_controller.text,
      email: email_controller.text,
      data: data_controller.text,
      cargo: job_controller.text,
    );
    final json = user.toJson();
    await docUser.set(json);
  }
}

class User {
  String id;
  final String nome;
  final String email;
  final String data;
  final String cargo;

  User({
    this.id = '',
    required this.nome,
    required this.email,
    required this.data,
    required this.cargo,
  });

  Map<String, dynamic> toJson() =>
      {'id': id, 'nome': nome, 'email': email, 'data': data, 'cargo': cargo};
}
