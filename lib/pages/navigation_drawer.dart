import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DrawerPage extends StatefulWidget {
  DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  ListView listView = ListView(
    children: <Widget>[
      DrawerHeader(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 151, 161, 170),
        ),
        child: Image.asset('assets/decibels.png'),
      ),
      ListTile(
        leading: const Icon(Icons.person),
        title: const Text('Perfil'),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.home),
        title: const Text('Página principal'),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.disc_full),
        title: const Text('Biblioteca'),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.question_mark),
        title: const Text('Términos'),
        onTap: () {},
      ),
      ListTile(
        leading: const FaIcon(FontAwesomeIcons.signOutAlt),
        title: const Text('Salir'),
        onTap: () async {
          FirebaseAuth.instance.signOut();
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Decibels'),
      ),
      drawer: Drawer(
        child: listView,
      ),
    );
  }
}
