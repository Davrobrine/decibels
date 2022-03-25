import 'dart:ffi';
import 'package:decibels/pages/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  static const String routeName = "/Registro";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _phoneTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFC857),
      appBar: AppBar(
        backgroundColor: const Color(0xff208AAE),
        title: const Center(
          child: Text("¡Regístrate!"),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            TextField(
              controller: _nameTextController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(label: Text('Nombre')),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailTextController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(label: Text('Email')),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordTextController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(label: Text('Contraseña')),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _phoneTextController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(label: Text('Teléfono')),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                UserCredential user =
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: _emailTextController.text,
                  password: _passwordTextController.text,
                );
                userSetup(
                    _nameTextController.text,
                    _passwordTextController.text,
                    _emailTextController.text,
                    _phoneTextController.text);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                 primary: const Color(0xff208AAE),
              ),
              icon: const FaIcon(
                FontAwesomeIcons.check,
                size: 32,
              ),
              label: const Text(
                'Registrarse',
                style: TextStyle(fontSize: 24),
               
              ),
            )
          ],
        ),
      ),
    );
  }
}
