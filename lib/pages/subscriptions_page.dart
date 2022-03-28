import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decibels/pages/profile_page.dart';
import 'package:flutter/material.dart';

class Subscriptions extends StatelessWidget {
  final String userId;
  final CollectionReference usersCollection;
  Subscriptions(this.userId, this.usersCollection, {Key? key})
      : super(key: key);

  static const String routeName = "/Subscriptions";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Lista de usuarios seguidos"),
        ),
        backgroundColor: const Color(0xff208AAE),
      ),
      body: FutureBuilder(
        future: usersCollection.doc(userId).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return ListView.builder(
              itemCount: data['followingUsers'].length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {
                    String userId = data['followingUsers'][index]['uid'];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Perfil(userId),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(data['followingUsers'][index]['photourl']),
                  ),
                  title: Text(
                    data['followingUsers'][index]['name'],
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 26.0),
                  ),
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
