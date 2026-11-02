import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_planner/models/note_model.dart';
import 'package:study_planner/services/database/store_images.dart';

class NoteService {
  // collection reference
  final CollectionReference _courseCollection = FirebaseFirestore.instance
      .collection('courses');

  // create note
  Future<void> createNote(String courseId, Note note) async {
    try {
      // store image in storage if exists
      String? imageUrl;

      if (note.imageData != null) {
        imageUrl = await StorageService().uploadImage(
          noteImage: note.imageData!,
          courseId: courseId,
        );
      }

      // create new note
      final Note newNote = Note(
        id: "",
        title: note.title,
        description: note.description,
        sectionName: note.sectionName,
        referenceBook: note.referenceBook,
        imagePath: imageUrl,
      );

      // create note collection reference
      final CollectionReference noteCollection = _courseCollection
          .doc(courseId)
          .collection("notes");

      final Map<String, dynamic> data = newNote.toJson();
      DocumentReference docRef = await noteCollection.add(data);
      await docRef.update({"id": docRef.id});

      print("Note added");
    } catch (error) {
      print("Error in creating note in service : $error");
    }
  }
}
