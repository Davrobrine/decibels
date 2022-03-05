import 'package:flutter/material.dart';

class Terminos extends StatelessWidget {
  static const String routeName = "/Terminos";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: new Text("Términos y Condiciones"),
        ),
         backgroundColor:Color.fromARGB(118, 31, 89, 128),
      ),
    );
  }
}
