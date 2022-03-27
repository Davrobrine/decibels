import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decibels/classes/Storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:get/get.dart';

class CrearAlbum extends StatefulWidget {
  CrearAlbum({Key? key}) : super(key: key);

  @override
  State<CrearAlbum> createState() => _CrearAlbumState();
}

class _CrearAlbumState extends State<CrearAlbum> {
  final storage = Storage();

  final user = FirebaseAuth.instance.currentUser!;
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  final _albumName = TextEditingController();
  final _albumDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Text('Añadir Album'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            TextField(
              controller: _albumName,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration:
                  const InputDecoration(label: Text('Nombre del Album')),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _albumDescription,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(label: Text('Descripcion')),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                final results = await FilePicker.platform.pickFiles(
                  allowMultiple: false,
                  type: FileType.custom,
                  allowedExtensions: ['jpg'],
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
                String userPath = 'albums/${user.uid}/${_albumName.text}';
                storage
                    .updateFile(path!, fileName, userPath)
                    .then((value) => print('Archivo subido'));

                var albumObj = {
                  'albumAuthor': user.displayName,
                  'albumDescription': _albumDescription.text,
                  'albumName': _albumName.text,
                  'coverUrl': fileName,
                };

                DocumentReference docRef = usersCollection.doc(user.uid);
                DocumentSnapshot doc = await docRef.get();

                List albums = doc['albums'];

                docRef.update({
                  'albums': FieldValue.arrayUnion([albumObj])
                });

                usersCollection
                    .doc(user.uid)
                    .collection('albums')
                    .doc(_albumName.text)
                    .set({
                  'albumAuthor': user.displayName,
                  'albumDescription': _albumDescription.text,
                  'albumName': _albumName.text,
                  'coverUrl': fileName,
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Archivo subido'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                primary: const Color.fromARGB(255, 221, 22, 22),
              ),
              icon: const Icon(
                Icons.create_new_folder,
                size: 32,
              ),
              label: const Text(
                'Crear Album',
                style: TextStyle(fontSize: 24),
              ),
            )
          ],
        ),
      ),
    );
  }
}
