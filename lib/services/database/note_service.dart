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

  // get notes by course id
  Stream<List<Note>> getNotes(String courseId) {
    try {
      // note collection reference
      final CollectionReference noteCollection = _courseCollection
          .doc(courseId)
          .collection('notes');

      return noteCollection.snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => Note.fromJson(doc.data() as Map<String, dynamic>))
            .toList(),
      );
    } catch (error) {
      throw Exception(
        "Error in fetching notes by course id $courseId : $error",
      );
    }
  }

  // get notes with course name as a map
  Future<Map<String, List<Note>>> getNotesWithCourseName() async {
    try {
      final QuerySnapshot snapshot = await _courseCollection.get();
      final Map<String, List<Note>> notesMap = {};

      for (final doc in snapshot.docs) {
        // get course id
        String courseId = doc.id;

        // get all notes under course id
        List<Note> notes = await getNotes(courseId).first;

        // create key value pairs
        notesMap[doc['name']] = notes;
      }

      return notesMap;
    } catch (error) {
      throw Exception("Error in fetching notes with course name : $error");
    }
  }
}
