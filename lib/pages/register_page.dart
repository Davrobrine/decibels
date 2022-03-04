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
      appBar: AppBar(
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
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
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
