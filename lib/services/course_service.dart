import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_planner/models/course_model.dart';

class CourseService {
  // collection reference
  final CollectionReference _courseCollection = FirebaseFirestore.instance
      .collection('courses');

  // add new course to collection
  Future<void> addCourse(Course course) async {
    try {
      // convertng to json
      final data = course.toJson();
      final DocumentReference docRef = await _courseCollection.add(data);
      docRef.update({"id": docRef.id});

      print("Course added");
    } catch (error) {
      print("Error in adding new course : $error");
    }
  }

  // get courses from firebase
  Stream<List<Course>> getCourses() {
    return _courseCollection.snapshots().map(
      (snapshot) => snapshot.docs
          .map(
            (doc) =>
                Course.fromJson(doc.data() as Map<String, dynamic>, doc.id),
          )
          .toList(),
    );
  }

  // delete course
  Future<void> deleteCourse(String id) async {
    try {
      await _courseCollection.doc(id).delete();
    } catch (error) {
      print("Error in deleting course : $error");
    }
  }
}
