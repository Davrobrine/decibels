import 'package:decibels/classes/Storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../main.dart';

class Authenticator {
  static CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth authenticator = FirebaseAuth.instance;
    User? user;

    GoogleSignIn objGoogleSignIn = GoogleSignIn();
    GoogleSignInAccount? objGoogleSignInAccount =
        await objGoogleSignIn.signIn();

    if (objGoogleSignInAccount != null) {
      GoogleSignInAuthentication objGoogleSignInAuthentication =
          await objGoogleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: objGoogleSignInAuthentication.accessToken,
        idToken: objGoogleSignInAuthentication.idToken,
      );

      try {
        UserCredential userCredential =
            await authenticator.signInWithCredential(credential);
        user = userCredential.user;

        usersCollection.get().then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((element) {
            if (element.id != user!.uid) {
              addUser(user);
              navigatorKey.currentState!.popUntil((route) => route.isFirst);
            } else {
              navigatorKey.currentState!.popUntil((route) => route.isFirst);
            }
          });
        });

        // addUser(user);
        // navigatorKey.currentState!.popUntil((route) => route.isFirst);
        return user;
      } on FirebaseAuthException catch (e) {
        print('Error en la autenticación');
      }
    }
  }

  //Añade el usuario creado con Google en Firestore Database
  static Future<void> addUser(User? user) async {
    usersCollection.doc(user!.uid).set({
      'userId': user.uid,
      'name': user.displayName,
      'email': user.email,
      'phone': user.phoneNumber,
      'photourl': user.photoURL,
    });

    print(usersCollection.doc(user.uid));
  }
}
