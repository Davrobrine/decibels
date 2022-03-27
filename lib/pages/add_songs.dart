import 'package:flutter/material.dart';

class AnadirCanciones extends StatefulWidget {
  const AnadirCanciones({Key? key}) : super(key: key);

  @override
  State<AnadirCanciones> createState() => _AnadirCancionesState();
}

class _AnadirCancionesState extends State<AnadirCanciones> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Text('Añadir canción a el album'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: 200,
                  width: 250,
                  //color: Colors.black,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Container(
                        height: 70,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/persona1.jpg',
                              ),
                              Text(
                                '\u{2795} Añadir Portada',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration:
                  const InputDecoration(label: Text('Nombre de la canción')),
            ),
            const SizedBox(height: 20),
            TextField(
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(label: Text('Autor')),
            ),
            const SizedBox(height: 20),
            TextField(
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(label: Text('Descripcion')),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                primary: Color.fromARGB(255, 221, 22, 22),
              ),
              icon: const Icon(
                Icons.create_new_folder,
                size: 32,
              ),
              label: const Text(
                'Añadir Canción',
                style: TextStyle(fontSize: 24),
              ),
            )
          ],
        ),
      ),
    );
  }
}
