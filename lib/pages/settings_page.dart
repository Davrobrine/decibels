import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Configuracion extends StatelessWidget {
  final String userId;
  final CollectionReference usersCollection;
  Configuracion(this.userId, this.usersCollection, {Key? key})
      : super(key: key);

  static const String routeName = "/Configuracion";

  final _nameText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configuración"),
        backgroundColor: const Color(0xff208AAE),
      ),
      body: SingleChildScrollView(
        
        child: Column(
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
             
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _nameText,
                decoration: const InputDecoration(
                  labelText: "Nombre",
                ),
              ),
            ),

            Container(
              child: ElevatedButton(
                child: const Text("Cambiar Nombre de usuario"),
                onPressed: () {
                  usersCollection.doc(userId).set({
                    'name': _nameText.text,
                  }, SetOptions(merge: true));
                },
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
      ),
    );
  }
}
