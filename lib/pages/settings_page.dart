import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  static const String routeName = "/Configuracion";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Configuración"),
      ),
      body: Column(
        children: [
          new Container(
            child: new Container(
              child: Image.asset('assets/user.png', width: 100),
            ),
          ),

          Row(
            children: [
              Container(
                child: RaisedButton(
                  child: Icon(Icons.add_circle),
                  onPressed: () {},
                ),
              ),
              Container(
                child: new Text(" Cambiar imagen  "),
              ),
            ],
          ),

          //text ingreso nombre
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.supervised_user_circle),
                labelText: "Nombre",
              ),
              onChanged: (value) {},
            ),
          ),

          Container(
            child: RaisedButton(
              child: Text("Cambiar Nombre de usuario"),
              onPressed: () {},
            ),
          ),
          //Text Ingreso contraseña
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.password),
                labelText: "Contraseña",
              ),
              onChanged: (value) {},
            ),
          ),
          Container(
            child: RaisedButton(
              child: Text("Cambiar Contraseña"),
              onPressed: () {},
            ),
          ),
          //Text ingreso descripcion
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.text_fields_sharp),
                labelText: "Descripcion",
              ),
              onChanged: (value) {},
            ),
          ),
          Container(
            child: RaisedButton(
              child: Text("Cambiar acerca de mi"),
              onPressed: () {},
            ),
          ),
          Container(
            child: new Text("Se enviará un correo de verificación"),
          ),
          Container(
            child: RaisedButton(
              child: Text("Guardar Cambios"),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
