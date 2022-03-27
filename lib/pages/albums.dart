import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decibels/classes/DataController.dart';
import 'package:decibels/pages/create_album.dart';
import 'package:decibels/pages/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'customList.dart';
import 'generate_album.dart';

class Album extends StatefulWidget {
  Album({Key? key}) : super(key: key);

  @override
  State<Album> createState() => _AlbumState();
}

class _AlbumState extends State<Album> {
  @override
  void initState() {
    super.initState();
  }

  List musicList = [
    {
      'albun': "Esto es un albun",
      'singer': "Creador o copositor",
      'coverUrl':
          "https://firebasestorage.googleapis.com/v0/b/decibels-3361d.appspot.com/o/intento%2Fnunca_es_suficiente.jpg?alt=media&token=406fb9aa-96a9-491c-8107-0fa888b82d04"
    },
    {
      'albun': "Otro albun",
      'singer': "otro compositor",
      'coverUrl':
          "https://firebasestorage.googleapis.com/v0/b/decibels-3361d.appspot.com/o/intento%2Frata_blamca.jpg?alt=media&token=3246e394-dceb-45c4-921e-7a95895f6d03"
    },
  ];

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
              builder: (context) => CrearAlbum(),
            ),
          );
        },
        label: const Text(
          'Generar Album',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.add_circle,
        ),
        elevation: 10,
      ),
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Albums',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: FutureBuilder(
        future: usersCollection.doc(user.uid).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return ListView.builder(
              itemCount: data['albums'].length,
              itemBuilder: (BuildContext context, int index) {
                String albumName = data['albums'][index]['albumName'];
                String fileName = data['albums'][index]['coverUrl'];
                String userPath = 'albums/${user.uid}/$albumName/$fileName';

                return FutureBuilder(
                  future: firestoreStorage().getData(userPath),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      print(snapshot.data.toString());
                      return Column(
                        children: [
                          customListTitle(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GenerarAlbum(),
                                ),
                              );
                            },
                            title: data['albums'][index]['albumName'],
                            singer: data['albums'][index]['albumAuthor'],
                            cover: snapshot.data.toString(),
                            //añadir texto añadir canción
                          ),
                        ],
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              },
            );
          }

          return Text("loading");
        },
      ),
    );
  }
}

class firestoreStorage {
  String? coverUrl;

  Future getData(userPath) async {
    try {
      await downloadURL(userPath);
      return coverUrl;
    } catch (e) {
      return null;
    }
  }

  Future<void> downloadURL(userPath) async {
    coverUrl = await FirebaseStorage.instance.ref(userPath).getDownloadURL();

    print('el link: ${coverUrl}');
  }
}
