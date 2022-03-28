import 'package:firebase_storage/firebase_storage.dart';

class FirestoreStorage {
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
