import 'package:cloud_firestore/cloud_firestore.dart';
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
        title: Center(
          child: new Text("Lista de subscripciones"),
        ),
        backgroundColor: const Color(0xff208AAE),
      ),
      body: FutureBuilder(
        future: usersCollection.doc(userId).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return ListView.builder(
              itemCount: data['followingUsers'].length,
              itemBuilder: (BuildContext context, int index) {
                return Text(data['followingUsers'][index]['name']);
              },
            );
          }

          return Text("loading");
        },
      ),
    );
  }
}
