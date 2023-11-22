import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:shared_preferences/shared_preferences.dart';

//create a variable to define wheather loading or not

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // properities of _StudentState class
  String? nome;
  String? data_nasc;
  String? cargo;
  String? email;

  // createStudent onPress create button

  // getStudent onPress Get button (for console only)
  getStudent() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    final User? user = auth.currentUser;
    final uid = user?.email;
    // here you write the codes to input the data into firestore

    users.doc(uid).get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        nome = data['nome'];
        email = data['email'];
        cargo = data['cargo'];
        data_nasc = data['data'];

        print(nome);
        print(email);
        print(cargo);
        print(data_nasc);

        // ...
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    getStudent();
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Center(
            child: Scaffold(
            body: Stack(children: [
              ClipPath(
                clipper: WaveClipperTwo(),
                child: Container(
                  decoration: BoxDecoration(color: Colors.blue.shade600),
                  height: 240,
                ),
              ),
              CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25.0, top: 60),
                      child: Text(
                        "Meu Perfil",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 25.0),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 12),
                      child: Text(
                        "Aqui estão os dados da sua conta na FastJobs",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 18.0),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 100),
                          child: Container(
                              width: 100,
                              height: 50,
                              color: Colors.grey.shade200,
                              child: Column(
                                children: [
                                  Padding(padding: EdgeInsets.only(top: 5)),
                                  Text('Nome'),
                                  Padding(padding: EdgeInsets.only(top: 5)),
                                  Text(nome.toString()),
                                ],
                              )))),
                  SliverToBoxAdapter(
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30),
                          child: Container(
                              width: 100,
                              height: 50,
                              color: Colors.grey.shade200,
                              child: Column(
                                children: [
                                  Padding(padding: EdgeInsets.only(top: 5)),
                                  Text('Cargo'),
                                  Padding(padding: EdgeInsets.only(top: 5)),
                                  Text(cargo.toString()),
                                ],
                              )))),
                  SliverToBoxAdapter(
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30),
                          child: Container(
                              width: 100,
                              height: 50,
                              color: Colors.grey.shade200,
                              child: Column(
                                children: [
                                  Padding(padding: EdgeInsets.only(top: 5)),
                                  Text('Data de Nascimento'),
                                  Padding(padding: EdgeInsets.only(top: 5)),
                                  Text(data_nasc.toString()),
                                ],
                              )))),
                  SliverToBoxAdapter(
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30),
                          child: Container(
                              width: 100,
                              height: 50,
                              color: Colors.grey.shade200,
                              child: Column(
                                children: [
                                  Padding(padding: EdgeInsets.only(top: 5)),
                                  Text('Email'),
                                  Padding(padding: EdgeInsets.only(top: 5)),
                                  Text(email.toString()),
                                ],
                              )))),
                ],
              ),
            ]),
          ));
  }
}
