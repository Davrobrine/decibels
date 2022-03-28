import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decibels/classes/Storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AnadirCanciones extends StatefulWidget {
  final int indexAlbum;
  const AnadirCanciones(this.indexAlbum, {Key? key}) : super(key: key);

  @override
  State<AnadirCanciones> createState() => _AnadirCancionesState();
}

class _AnadirCancionesState extends State<AnadirCanciones> {
  final storage = Storage();

  final user = FirebaseAuth.instance.currentUser!;
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  final _songName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Text('Añadir canción al album'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            TextField(
              controller: _songName,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration:
                  const InputDecoration(label: Text('Nombre de la canción')),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                final results = await FilePicker.platform.pickFiles(
                  allowMultiple: false,
                  type: FileType.custom,
                  allowedExtensions: ['mp3'],
                );
                if (results == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Ningun archivo seleccionado'),
                    ),
                  );
                  return null;
                }
                final path = results.files.single.path;
                final fileName = results.files.single.name;
                print("esto que es: $path");
                print(fileName);

                DocumentReference docRef = usersCollection.doc(user.uid);
                DocumentSnapshot doc = await docRef.get();
                String albumName =
                    doc['albums'][widget.indexAlbum]['albumName'];
                String userPath = 'albums/${user.uid}/${albumName}';

                DocumentReference songRef = usersCollection
                    .doc(user.uid)
                    .collection('albums')
                    .doc(albumName);

                DocumentSnapshot song = await songRef.get();
                print(song['albumName']);

                storage
                    .updateFile(path!, fileName, userPath)
                    .then((value) => print('Archivo subido'));

                var songObj = {
                  'songName': _songName.text,
                  'songUrl': fileName,
                };

                songRef.update({
                  'songs': FieldValue.arrayUnion([songObj])
                });

                // docRef.update({
                //   'albums': [
                //     {
                //       'songs': FieldValue.arrayUnion([songObj])
                //     }
                //   ]
                // });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Archivo subido'),
                  ),
                );
              },
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
