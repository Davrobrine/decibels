import 'package:flutter/material.dart';

class Terminos extends StatelessWidget {
  static const String routeName = "/Terminos";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: new Text("Politicas de Privacidad"),
        ),
     backgroundColor: const Color(0xff208AAE),
      ),
      body: Column(
      
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child:   Column(
              children: [
                Container(
      color:Colors.white,
      child: (
        Row(
          children: <Widget>[
           
            Column(
              children: <Widget>[
                Text("BEATSMOON",textAlign: TextAlign.center,),
                Text("Esta apliación se creó con el proposito de",textAlign: TextAlign.justify,),
                Text("proporcionar el servicio sin consto ",textAlign: TextAlign.justify,),

                Divider(
                  color: Colors.black,
                )
              ],
            )
          ],
        )
      )
                ),       
              ],  
            ),
          )
        ],
      ),
      backgroundColor: Color.fromARGB(118, 32, 138, 174),
    );
  }
}
    