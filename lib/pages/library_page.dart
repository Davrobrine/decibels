import 'package:flutter/material.dart';

class Biblioteca extends StatelessWidget {
  static const String routeName = "/Biblioteca";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: new Text("Decibels"),
        ),
      ),
      body: ListaBiblioteca(),
    );
  }
}

class Cancion {
  String nombre, artista, imagen;
  Cancion(this.nombre, this.artista, this.imagen);
}

class ListaBiblioteca extends StatefulWidget {
  @override
  _ListaBibliotecaState createState() => _ListaBibliotecaState();
}

class _ListaBibliotecaState extends State<ListaBiblioteca> {
  late List<Cancion> canciones;

  @override
  void initState() {
    canciones = [
      Cancion("Cancion 1", "artista 1", ''),
      Cancion("Cancion 2", "artista 2", ''),
      Cancion("Cancion 3", "artista 3", ''),
      Cancion("Cancion 4", "artista 4", ''),
      Cancion("Cancion 5", "artista 5", ''),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(canciones[index].nombre),
          subtitle: Text(canciones[index].artista),
          leading: Image.asset('/disco.png'),
          trailing: Icon(
            Icons.play_arrow,
            size: 30,
          ),
        );
      },
      itemCount: canciones.length,
    );
  }
}
