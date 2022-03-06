import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> userSetup(String displayName, String contrasena, String email,
    String telefono) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();
  users.doc(uid).set({
    'Nombre': displayName,
    'Contraseña': contrasena,
    'email': email,
    'Telefono': telefono,
    'Uid': uid
  });
  return;
}
