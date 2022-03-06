import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    String userText = '';

    if (user.email != null) {
      userText = user.email!;
    } else if (user.displayName != null) {
      userText = user.displayName!;
    }

    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Bienvenido',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 9),
          Text(
            userText,
            style:const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
