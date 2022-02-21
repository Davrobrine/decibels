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
      const DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Text(
          'Drawer Header',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      const ListTile(
        leading: Icon(Icons.settings),
        title: Text('Config'),
      ),
      const ListTile(
        leading: Icon(Icons.account_circle),
        title: Text('Profile'),
      ),
      TextButton.icon(
        onPressed: () async {
          FirebaseAuth.instance.signOut();
        },
        icon: const FaIcon(FontAwesomeIcons.signOutAlt),
        label: const Text('Salir'),
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
