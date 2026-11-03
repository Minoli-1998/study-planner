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

  // get assignment under relevant course id
  Stream<List<Assignment>> getAssignments(String courseId) {
    try {
      // aasignment collection reference
      final CollectionReference assignmentCollection = _courseCollection
          .doc()
          .collection("assignments");

      return assignmentCollection.snapshots().map(
        (snapshot) => snapshot.docs
            .map(
              (doc) => Assignment.fromJson(doc.data() as Map<String, dynamic>),
            )
            .toList(),
      );
    } catch (error) {
      throw Exception("Error in fetching assignments under $courseId : $error");
    }
  }

  // get all assignments from course collection with name as a map
  Future<Map<String, List<Assignment>>> getAssignmentsWithCourse() async {
    try {
      final QuerySnapshot snapshot = await _courseCollection.get();
      Map<String, List<Assignment>> assignmentMap = {};

      for (final doc in snapshot.docs) {
        // get course id
        String courseId = doc.id;

        // get assignment list under course id
        List<Assignment> assignments = await getAssignments(courseId).first;

        // create new key, value pair
        assignmentMap[doc['name']] = assignments;
      }

      return assignmentMap;
    } catch (error) {
      throw Exception("Error in fetching assignments with course name");
    }
  }
}
