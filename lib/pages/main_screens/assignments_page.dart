import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:study_planner/constants/app_text_styles.dart';
import 'package:study_planner/constants/colors.dart';
import 'package:study_planner/models/assignment_model.dart';
import 'package:study_planner/services/database/assignment_service.dart';
import 'package:study_planner/services/database/notification_service.dart';
import 'package:study_planner/widgets/countdown_timer.dart';

class AssignmentsPage extends StatelessWidget {
  const AssignmentsPage({super.key});

  Future<Map<String, List<Assignment>>> _fetchAssignment() async {
    return await AssignmentService().getAssignmentsWithCourse();
  }

  // method to check overdue assignments and store them in notifications collection
  Future<void> _checkAndStoreOverdueAssignments() async {
    await NotificationService().storeOverdueAssignments();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _checkAndStoreOverdueAssignments();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Assignments", style: AppTextStyles.appHeadingTextStyle),
        actions: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).push('/notifications');
            },
            icon: Icon(Icons.notifications),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: FutureBuilder(
          future: _fetchAssignment(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error  : ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No available data"));
            }

            final assignmentMap = snapshot.data!;

            return ListView.builder(
              itemCount: assignmentMap.keys.length,
              itemBuilder: (context, index) {
                final courseName = assignmentMap.keys.elementAt(index);
                final assignments = assignmentMap[courseName]!;

                return ExpansionTile(
                  title: Text(
                    courseName,
                    style: TextStyle(color: darkGreen, fontSize: 18),
                  ),
                  children: assignments.map((assignment) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        title: Text(
                          assignment.name,
                          style: AppTextStyles.appHeadingTextStyle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Due Date: ${DateFormat.yMMMd().format(assignment.dueDate)}",
                              style: AppTextStyles.appDescriptionTextStyle,
                            ),

                            Text(
                              "Duration: ${assignment.duration}",
                              style: AppTextStyles.appDescriptionTextStyle,
                            ),

                            Text(
                              "Description: ${assignment.description}",
                              style: AppTextStyles.appDescriptionTextStyle,
                            ),

                            CountdownTimer(dueDate: assignment.dueDate),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
