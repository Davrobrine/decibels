import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decibels/classes/Storage.dart';
import 'package:decibels/pages/add_songs.dart';
import 'package:decibels/pages/settings_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'customList.dart';

class GenerarAlbum extends StatefulWidget {
  String coverUrl;
  int indexAlbum;
  GenerarAlbum(this.coverUrl, this.indexAlbum, {Key? key}) : super(key: key);

  @override
  State<GenerarAlbum> createState() => _GenerarAlbumState();
}

class _GenerarAlbumState extends State<GenerarAlbum> {
  final user = FirebaseAuth.instance.currentUser!;
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        foregroundColor: Colors.white,
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AnadirCanciones(widget.indexAlbum),
            ),
          );
        },
        label: const Text(
          'Añadir Canciones',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.add,
        ),
        elevation: 10,
      ),
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Agregar Canciones',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: FutureBuilder(
        future: usersCollection.doc(user.uid).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            String albumName = data['albums'][widget.indexAlbum]['albumName'];

            DocumentReference albumSnapshot = usersCollection
                .doc(user.uid)
                .collection('albums')
                .doc(albumName);

            return Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 180.0,
                        width: 180.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: NetworkImage(widget.coverUrl),
                            )),
                      ),
                      Center(
                        child: SizedBox(
                          width: 150,
                          height: 150,
                          child: Text(
                            data['albums'][widget.indexAlbum]['albumName'],
                            maxLines: 4,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
                      // child: const Text('canciones'),
                      child: SizedBox(
                        height: 300.0,
                        child: FutureBuilder(
                          future: albumSnapshot.get(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              Map<String, dynamic> albumData =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              return ListView.builder(
                                itemCount: albumData['songs'].length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Text(
                                      albumData['songs'][index]['songName']);
                                },
                              );
                            }
                            return Text("loading");
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }

          return Text("loading");
        },
      ),
    );
  }
}
