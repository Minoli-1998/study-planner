import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_planner/models/assignment_model.dart';

class AssignmentService {
  // collection reference
  final CollectionReference _courseCollection = FirebaseFirestore.instance
      .collection('courses');

  // create assignment
  Future<void> createAssignment(String courseId, Assignment assignment) async {
    try {
      // assignment collection reference
      final CollectionReference assignmentCollection = _courseCollection
          .doc(courseId)
          .collection("assignments");

      final Map<String, dynamic> data = assignment.toJson();
      final DocumentReference docRef = await assignmentCollection.add(data);
      await docRef.update({"id": docRef.id});

      print("Assignment saved");
    } catch (error) {
      print("Error in creating assignment in service : $error");
    }
  }
}
