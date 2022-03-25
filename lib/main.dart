import 'package:decibels/classes/Storage.dart';
import 'package:decibels/pages/library_page.dart';
import 'package:decibels/pages/login_page.dart';
import 'package:decibels/pages/navigation_drawer.dart';
import 'package:decibels/pages/profile_page.dart';
import 'package:decibels/pages/register_page.dart';
import 'package:decibels/pages/settings_page.dart';
import 'package:decibels/pages/subscriptions_page.dart';
import 'package:decibels/pages/terms_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp().then((value) => runApp(const MyApp()));
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final Storage storage = Storage();
    return GetMaterialApp(

      title: 'BEATSMOON',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.red
      ),
      home: const MyHomePage(),
      routes: <String, WidgetBuilder>{
        DrawerPage.routeName: (BuildContext context) => DrawerPage(),
        // Perfil.routeName: (BuildContext context) => Perfil(),
        // Biblioteca.routeName: (BuildContext context) => Biblioteca(),
        Terminos.routeName: (BuildContext context) => Terminos(),
        // Settings.routeName: (BuildContext context) => Settings(),
        Subscriptions.routeName: (BuildContext context) => Subscriptions(),
        RegisterPage.routeName: (BuildContext context) => RegisterPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Algo ha ido mal!!'));
          } else if (snapshot.hasData) {
            return DrawerPage();
          } else {
            return LoginPage();
          }
        },
      ),
    );
    // return Scaffold(
    //   body: DrawerPage(),
    // );
  }
}
