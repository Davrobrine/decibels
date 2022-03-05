import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Perfil extends StatelessWidget {
  static const String routeName = "/Perfil";
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: new Text("Perfil"),
        ),
        backgroundColor: Color.fromARGB(118, 31, 89, 128),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 190,
            padding: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/fondo.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                UserFoto(
                  assetImage: user.photoURL.toString(),
                  size: 110,
                ),
                Text(
                  user.displayName!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20),
                ),
                Text(
                  user.email!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),
          ConeccionGeneral(
            suscripciones: 20,
            siguiendo: 15,
          ),
          Descripcion(
            text: 'Teléfono: ${user.phoneNumber}',
          ),
          Padding(
            padding: EdgeInsets.all(50),
          ),
          botonajuste(),
        ],
      ),
    );
  }
}

class botonajuste extends StatelessWidget {
  const botonajuste({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      foregroundColor: Colors.white,
      onPressed:(){},
      label: Text(
        'Ajustes',
        style: TextStyle(color: Colors.white),
      ),
      icon: Icon(Icons.edit),
      elevation: 10,
    );
  }
}

class Descripcion extends StatelessWidget {
  final String text;
  Descripcion({
    Key? key,
    required this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(this.text),
    );
  }
}

class ConeccionGeneral extends StatelessWidget {
  final int suscripciones, siguiendo;
  const ConeccionGeneral({
    Key? key,
    required this.suscripciones,
    required this.siguiendo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(118, 31, 89, 128),
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          conecciones(
            text: 'suscripciones',
            numero: this.suscripciones,
          ),
          conecciones(text: "Siguiendo", numero: this.siguiendo),
        ],
      ),
    );
  }
}

class conecciones extends StatelessWidget {
  final String text;
  final int numero;
  const conecciones({
    Key? key,
    required this.text,
    required this.numero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: Color.fromARGB(150, 0, 0, 0),
    );
    return Column(
      children: <Widget>[
        Text(
          this.text.toUpperCase(),
          style: style,
        ),
        Text(
          '${this.numero}',
          style: style,
        ),
      ],
    );
  }
}

class UserFoto extends StatelessWidget {
  final String assetImage;
  final double size;
  const UserFoto({
    Key? key,
    required this.assetImage,
    this.size = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.size,
      height: this.size,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(this.assetImage), fit: BoxFit.cover),
        shape: BoxShape.circle,
        border: Border.all(color: Color.fromARGB(255, 54, 127, 187), width: 4),
      ),
      margin: EdgeInsets.only(bottom: 10),
    );
  }
}
