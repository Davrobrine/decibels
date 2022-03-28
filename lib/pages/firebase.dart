import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> userSetup(String displayName, String contrasena, String email,
    String telefono) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();
  users.doc(uid).set({
    'userId': uid,
    'name': displayName,
    'email': email,
    'contraseña': contrasena,
    'phone': telefono,
    'photourl': null,
    'albums': [],
    'followers': 0,
    'followingUsers': [],
  });
  return;
}
