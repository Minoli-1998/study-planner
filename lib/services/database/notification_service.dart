import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_planner/models/notification_model.dart';
import 'package:study_planner/services/database/assignment_service.dart';

class NotificationService {
  // create collection reference
  final CollectionReference notificationCollection = FirebaseFirestore.instance
      .collection('notifications');

  // creat method to save overdue assignments
  Future<void> storeOverdueAssignments() async {
    try {
      // get course name and assignments as key values pairs
      final assignmentMap = await AssignmentService()
          .getAssignmentsWithCourse();

      for (final entry in assignmentMap.entries) {
        final courseName = entry.key;
        final assignments = entry.value;

        for (final assignment in assignments) {
          // check whethher the assignment already in notificaton collection
          final QuerySnapshot snapshot = await notificationCollection
              .where('assignmentId', isEqualTo: assignment.id)
              .get();

          // if snapshot is empty that's mean there is no assignment in notification collection with that id
          if (snapshot.docs.isEmpty) {
            // check if the assignment is overdue
            if (DateTime.now().isAfter(assignment.dueDate)) {
              final notificationData = NotificationModel(
                assignmentId: assignment.id,
                assignmentName: assignment.name,
                courseName: courseName,
                description: assignment.description,
                dueDate: assignment.dueDate,
                timePassed: "Overdue",
              );

              await notificationCollection.add(notificationData.toJson());
            }
          }
        }
      }
    } catch (error) {
      print("Error : $error");
    }
  }

  // fetch overdue assignments
  Stream<List<NotificationModel>> fetchNotifications() {
    return notificationCollection.snapshots().map(
      (snapshot) => snapshot.docs
          .map(
            (doc) =>
                NotificationModel.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
