import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decibels/classes/FirestoreStorage.dart';
import 'package:decibels/classes/Storage.dart';
import 'package:decibels/pages/albumPlayer_page.dart';
import 'package:decibels/pages/albums.dart';
import 'package:decibels/pages/generate_album.dart';
import 'package:decibels/pages/settings_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Perfil extends StatelessWidget {
  final String userId;
  // final CollectionReference usersCollection;
  Perfil(this.userId, {Key? key}) : super(key: key);

  static const String routeName = "/Perfil";
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: usersCollection.doc(userId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          int followers = data['followers'];
          int followingUsers = data['followingUsers'].length;

          return Scaffold(
            appBar: AppBar(
              title: const Center(
                child: Text("Perfil"),
              ),
              backgroundColor: const Color(0xff208AAE),
              actions: <Widget>[
                botonajuste(userId),
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 190,
                  padding: const EdgeInsets.only(bottom: 20),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/fondo.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      UserFoto(
                        assetImage: data['photourl'],
                        size: 110,
                      ),
                      Text(
                        data['name'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                      Text(
                        data['email'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                ConeccionGeneral(
                  suscripciones: followers,
                  siguiendo: followingUsers,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Albumes de ${data['name']}',
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 300,
                  width: 450,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: usersCollection
                        .doc(userId)
                        .collection('albums')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }

                      if (snapshot.hasData) {
                        return ListView(
                          scrollDirection: Axis.horizontal,
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;

                            String albumName = data['albumName'];
                            String fileName = data['coverUrl'];
                            String userPath =
                                'albums/${userId}/$albumName/$fileName';

                            return FutureBuilder(
                              future: FirestoreStorage().getData(userPath),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                String coverUrl = snapshot.data.toString();
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AlbumPlayer(
                                            albumName,
                                            userId,
                                            coverUrl,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.contain,
                                              image: NetworkImage(coverUrl),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Container(
                                            constraints: const BoxConstraints(
                                                maxWidth: 150),
                                            child: Text(
                                              data['albumName'],
                                              style: const TextStyle(
                                                  fontSize: 20.0),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(7.0),
                                          child: Text(
                                            data['albumAuthor'],
                                            style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        );
                      }

                      return const CircularProgressIndicator();
                    },
                  ),
                )
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class botonajuste extends StatelessWidget {
  final String userId;
  const botonajuste(this.userId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    final actualUser = FirebaseAuth.instance.currentUser!;
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    if (userId == actualUser.uid) {
      return IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Album(),
            ),
          );
        },
        icon: const Icon(
          Icons.upgrade,
          size: 38,
        ),
      );
    }

    return IconButton(
      onPressed: () async {
        DocumentReference docRef = usersCollection.doc(userId);
        DocumentSnapshot doc = await docRef.get();

        DocumentReference actualDocRef = usersCollection.doc(actualUser.uid);
        DocumentSnapshot actualDoc = await actualDocRef.get();

        List following = actualDoc['followingUsers'];

        var userObj = {
          'photourl': doc['photourl'],
          'uid': userId,
          'name': doc['name'],
        };

        int followers = doc['followers'];

        if (following.length == 0) {
          actualDocRef.update({
            'followingUsers': FieldValue.arrayUnion([userObj])
          });

          followers += 1;
          usersCollection.doc(userId).set({
            'followers': followers,
          }, SetOptions(merge: true));
        }

        for (int i = 0; i < following.length; i++) {
          if (following[i]['uid'].contains(userObj['uid']) == true) {
            actualDocRef.update({
              'followingUsers': FieldValue.arrayRemove([userObj])
            });

            followers -= 1;
            usersCollection.doc(userId).set({
              'followers': followers,
            }, SetOptions(merge: true));
          } else {
            actualDocRef.update({
              'followingUsers': FieldValue.arrayUnion([userObj])
            });

            followers += 1;
            usersCollection.doc(userId).set({
              'followers': followers,
            }, SetOptions(merge: true));
          }
        }
      },
      icon: const FaIcon(FontAwesomeIcons.plus),
    );
  }
}

class Descripcion extends StatelessWidget {
  final String text;
  Descripcion({
    Key? key,
    required this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(this.text),
    );
  }
}

class ConeccionGeneral extends StatelessWidget {
  final int suscripciones, siguiendo;
  const ConeccionGeneral({
    Key? key,
    required this.suscripciones,
    required this.siguiendo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(118, 31, 89, 128),
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          conecciones(
            text: 'Seguidores',
            numero: this.suscripciones,
          ),
          conecciones(text: "Siguiendo", numero: this.siguiendo),
        ],
      ),
    );
  }
}

class conecciones extends StatelessWidget {
  final String text;
  final int numero;
  const conecciones({
    Key? key,
    required this.text,
    required this.numero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(color: Color.fromARGB(150, 0, 0, 0));
    return Column(
      children: <Widget>[
        Text(
          this.text.toUpperCase(),
          style: style,
        ),
        Text(
          '${this.numero}',
          style: style,
        ),
      ],
    );
  }
}

class UserFoto extends StatelessWidget {
  final String assetImage;
  final double size;
  const UserFoto({
    Key? key,
    required this.assetImage,
    this.size = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.size,
      height: this.size,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(this.assetImage), fit: BoxFit.cover),
        shape: BoxShape.circle,
        border: Border.all(color: Color.fromARGB(255, 54, 127, 187), width: 4),
      ),
      margin: EdgeInsets.only(bottom: 10),
    );
  }
}
