import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  static const String routeName = "/Configuracion";

  @override
  Widget build(BuildContext context) {
 
  return new Scaffold(
      appBar: new AppBar(
        title:  Text("Configuración"),
         backgroundColor:Color.fromARGB(118, 31, 89, 128),
      ),
     
      body: Column(
        children: [
           Row(
            children: [
              Container(
                child: RaisedButton(
                  
                  child: Icon(Icons.add_circle),
                  onPressed: () {},
                ),
              ),
              Container(
                child: new Text(" Cambiar imagen"),
              ),
            ],
          ),

          //text ingreso nombre
          Row(
            children:[
          Container(
            decoration: BoxDecoration(
              border:Border.all(color: Colors.blue),
            ),
          
            child: TextField(
              decoration: InputDecoration(
             
                labelText: "Cambiar nombre",
              ),
              onChanged: (value) {},
            ),
          ),

          Container(
            child: RaisedButton(
              child: Icon(Icons.save),
              onPressed: () {},
            ),
          ),
            ],
          ),
          //Text Ingreso contraseña
          Container(
            decoration: BoxDecoration(
              border:Border.all(color: Colors.blue),
            ),
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: TextField(
              decoration: InputDecoration(

              
                labelText: "Cambiar Contraseña",
              ),
              onChanged: (value) {},
            ),
          ),
          Container(
            child: RaisedButton(
              child: Icon(Icons.save),
              onPressed: () {},
            ),
          ),
          //Text ingreso descripcion
          Container(
            decoration: BoxDecoration(
              border:Border.all(color: Colors.blue),
                ),
          
            child: TextField(
              decoration: InputDecoration(
              
                labelText: "Descripcion",
              ),
              onChanged: (value) {},
            ),
          ),
          Container(
            child: RaisedButton(
              child: Icon(Icons.save),
              onPressed: () {},
            ),
          ),
          Container(
            child: new Text("Se enviará un correo de verificación"),
          ),
        ],
      ),
    );
      
  }
}
