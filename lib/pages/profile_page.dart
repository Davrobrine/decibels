import 'package:flutter/material.dart';

class Perfil extends StatelessWidget {
  static const String routeName = "/Perfil";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: new Text("Decibels"),
        ),
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
                  assetImage: 'assets/persona1.jpg',
                  size: 110,
                ),
                Text(
                  "Usuario",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 20),
                ),
                Text(
                  "Correo@ejemplo.com",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ],
            ),
          ),
          ConeccionGeneral(
            suscriociones: 20,
            siguiendpo: 15,
          ),
          Descripcion(
            text: "Informacion que pondra el usuario",
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
      foregroundColor: Colors.cyanAccent,
      onPressed: null,
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
      padding: EdgeInsets.all(20),
      child: Text(this.text),
    );
  }
}

class ConeccionGeneral extends StatelessWidget {
  final int suscriociones, siguiendpo;
  const ConeccionGeneral({
    Key? key,
    required this.suscriociones,
    required this.siguiendpo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(40, 0, 255, 0),
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          conecciones(
            text: 'suscripciones',
            numero: this.suscriociones,
          ),
          conecciones(text: "Siguiendo", numero: this.siguiendpo),
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
            image: AssetImage(this.assetImage), fit: BoxFit.cover),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.blue, width: 4),
      ),
      margin: EdgeInsets.only(bottom: 10),
    );
  }
}
