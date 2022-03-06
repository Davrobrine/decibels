import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  static const String routeName = "/Configuracion";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Configuración"),
        backgroundColor: Color.fromARGB(118, 31, 89, 128),
      ),
      body: Column(
        children: [
          Container(
            child: Container(
              child: Image.asset('assets/user.png', width: 70),
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
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
            ),
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: TextField(
              decoration: InputDecoration(
                // icon: Icon(Icons.supervised_user_circle),
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
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
            ),
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: TextField(
              decoration: InputDecoration(
                // icon: Icon(Icons.password),
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
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
            ),
            child: TextField(
              decoration: InputDecoration(
                //icon: Icon(Icons.text_fields_sharp),
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
