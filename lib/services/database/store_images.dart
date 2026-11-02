import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  // firebase storage instance
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // method to upload image to firebase storage folder and get image url;
  Future<String> uploadImage({
    required File noteImage,
    required String courseId,
  }) async {
    try {
      // reference for storage folder
      Reference ref = _storage
          .ref()
          .child("note-images")
          .child("$courseId/${DateTime.now()}");

      UploadTask task = ref.putFile(
        noteImage,
        SettableMetadata(contentType: "image/jpeg"),
      );

      TaskSnapshot snapshot = await task;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      throw Exception("Error in uploading image : $error");
    }
  }
}
