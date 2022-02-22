import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DrawerPage extends StatefulWidget {
  DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Decibels'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 186, 198, 206),
              ),
              child: Image.asset('assets/decibels.png'),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Página principal'),
              onTap: () {
                Navigator.of(context).pushNamed('/');
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                setState(() {
                  Navigator.of(context).pushNamed('/Perfil');
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.disc_full),
              title: const Text('Biblioteca'),
              onTap: () {
                Navigator.of(context).pushNamed('/Biblioteca');
              },
            ),
            ListTile(
              leading: const Icon(Icons.subscriptions),
              title: const Text('Suscripciones'),
              onTap: () {
                Navigator.of(context).pushNamed('/Subscriptions');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuracion'),
              onTap: () {
                Navigator.of(context).pushNamed('/Configuracion');
              },
            ),
            ListTile(
              leading: const Icon(Icons.offline_bolt),
              title: const Text('Offline'),
              onTap: () {
                Navigator.of(context).pushNamed('/Offline');
              },
            ),
            ListTile(
              leading: const Icon(Icons.question_mark),
              title: const Text('Términos'),
              onTap: () {
                Navigator.of(context).pushNamed('/Terminos');
              },
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.signOutAlt),
              title: const Text('Salir'),
              onTap: () async {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
