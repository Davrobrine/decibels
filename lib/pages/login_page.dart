import 'package:decibels/classes/authenticator.dart';

import '../main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Map? userData;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Image.asset('assets/decibels.png'),
          const SizedBox(height: 20),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border:Border.all(color: Colors.blueGrey),
            ),
          child: TextField(
            controller: _emailController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
               icon: Icon(Icons.email),
              label: Text('Email')
              ),

          ),
          ),

          const SizedBox(height: 4),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border:Border.all(color: Colors.blueGrey),
        ),
          child: TextField(

            controller: _passwordController,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              icon: Icon(Icons.password),
              label: Text('Contraseña')
            ),
            obscureText: true,
          ),
      ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.lightBlueAccent,
              minimumSize: const Size.fromHeight(50),
            ),
            icon: const Icon(Icons.login, size: 32),
            label: const Text(
              'Iniciar Sesion',
              style: TextStyle(fontSize: 24),
            ),
            onPressed: signIn,
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () async {
              User? user =
                  await Authenticator.signInWithGoogle(context: context);

              print(user?.displayName);
            },
            style: ElevatedButton.styleFrom(
              primary:  Colors.blue,
              minimumSize: const Size.fromHeight(50),
            ),
            icon: const FaIcon(
              FontAwesomeIcons.google,
              color: Colors.white,
              size: 32,
            ),
            label: const Text(
              'Entra con Google',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pushNamed('/Registro');
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
            icon: const FaIcon(
              FontAwesomeIcons.user,
              size: 32,
            ),
            label: const Text(
              'Registrarse',
              style: TextStyle(fontSize: 24),
            ),
          )
        ],
      ),
    );
  }

  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
