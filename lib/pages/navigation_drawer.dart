import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decibels/classes/DataController.dart';
import 'package:decibels/pages/home_page.dart';
import 'package:decibels/pages/library_page.dart';
import 'package:decibels/pages/profile_page.dart';
import 'package:decibels/pages/search.dart';
import 'package:decibels/pages/settings_page.dart';
import 'package:decibels/pages/settings_page.dart';
import 'package:decibels/pages/subscriptions_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerPage extends StatefulWidget {
  DrawerPage({Key? key}) : super(key: key);
  static const String routeName = "/Inicio";

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  final user = FirebaseAuth.instance.currentUser!;
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    final userId = user.uid;

    return Scaffold(
      appBar: AppBar(
        ///centerTitle: new Text('Decibels'),
        backgroundColor: const Color(0xff208AAE),
        title: const Center(
          child: Text("BEATSMOON"),
        ),
        actions: <Widget>[
          GetBuilder<DataController>(
            init: DataController(),
            builder: (val) {
              return IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Busqueda(),
                    ),
                  );
                },
                icon: Icon(Icons.search),
              );
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: const Color(0xff208AAE),
              ),
              child: Image.asset('assets/logof.png'),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Perfil(userId),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.library_music),
              title: const Text('Biblioteca'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Biblioteca(userId),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.subscriptions),
              title: const Text('Suscripciones'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Subscriptions(userId, usersCollection),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Configuracion(userId, usersCollection),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.plagiarism_rounded),
              title: const Text('Términos'),
              onTap: () {
                // Navigator.of(context).pushNamed('/Terminos');
                launch(
                    'https://beatsmoon.000webhostapp.com/politics_privacy.html');
              },
            ),
            ListTile(
              leading: const Icon(Icons.web),
              title: const Text('Nuestra WEB'),
              onTap: () {
                // Navigator.of(context).pushNamed('/Terminos');
                launch('https://beatsmoon.000webhostapp.com/');
              },
            ),
            ListTile(
              leading: const Icon(Icons.radio),
              title: const Text('Radio'),
              onTap: () {
                // Navigator.of(context).pushNamed('/Terminos');
                launch('https://toluvaradio.000webhostapp.com/');
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
      body: HomePage(userId, usersCollection),
      backgroundColor: const Color(0xff208AAE),
    );
  }
}
