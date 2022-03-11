import 'package:flutter/material.dart';

class Subscriptions extends StatelessWidget {
  static const String routeName = "/Subscriptions";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: new Text("Lista de subscripciones"),
        ),
         backgroundColor:Color.fromARGB(118, 31, 89, 128),
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
      Cancion("Artista 1", "artista 1", ''),
      Cancion("Artista 2", "artista 2", ''),
      Cancion("Artista 3", "artista 3", ''),
      Cancion("Artista 4", "artista 4", ''),
      Cancion("Artista 5", "artista 5", ''),
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
          leading: Icon(Icons.supervised_user_circle),
          trailing: RaisedButton(
            child: new Icon(Icons.add_alert_sharp),
            onPressed: () {},
          ),
        );
      },
      itemCount: canciones.length,
    );
  }
}
