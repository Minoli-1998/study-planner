import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:study_planner/constants/app_text_styles.dart';
import 'package:study_planner/constants/colors.dart';
import 'package:study_planner/models/assignment_model.dart';
import 'package:study_planner/models/course_model.dart';
import 'package:study_planner/models/note_model.dart';
import 'package:study_planner/services/database/assignment_service.dart';
import 'package:study_planner/services/database/course_service.dart';
import 'package:study_planner/services/database/note_service.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  // method to fetch data
  Future<Map<String, dynamic>> _fetchData() async {
    try {
      final courses = await CourseService().getAllCourses();
      final assignmentsMap = await AssignmentService()
          .getAssignmentsWithCourse();
      final notesMap = await NoteService().getNotesWithCourseName();

      return {
        "courses": courses,
        "assignments": assignmentsMap,
        "notes": notesMap,
      };
    } catch (error) {
      print(error);
      return {"courses": [], "assignments": {}, "notes": {}};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Courses", style: AppTextStyles.appHeadingTextStyle),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FutureBuilder(
            future: _fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error : ${snapshot.error}"));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text("No available data"));
              }

              final List<Course> courses = snapshot.data!['courses'] ?? [];
              final Map<String, List<Assignment>> assignmentsMap =
                  snapshot.data!['assignments'] ?? {};
              final Map<String, List<Note>> notesMap =
                  snapshot.data!['notes'] ?? {};

              if (courses.isEmpty) {
                return SizedBox();
              } else {
                return ListView.builder(
                  itemCount: courses.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final Course course = courses[index];
                    final List<Assignment> assignments =
                        assignmentsMap[course.name] ?? [];
                    final List<Note> notes = notesMap[course.name] ?? [];

                    return Card(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 15,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              course.name,
                              style: AppTextStyles.appHeadingTextStyle.copyWith(
                                fontSize: 18,
                              ),
                            ),

                            SizedBox(height: 10),

                            Text(
                              "Description : ${course.description}",
                              style: AppTextStyles.appDescriptionTextStyle,
                            ),

                            SizedBox(height: 10),

                            Text(
                              "Duration: ${course.duration}",
                              style: AppTextStyles.appDescriptionTextStyle
                                  .copyWith(color: lightGreen),
                            ),

                            SizedBox(height: 5),

                            Text(
                              "Schedule: ${course.schedule}",
                              style: AppTextStyles.appDescriptionTextStyle
                                  .copyWith(color: lightGreen),
                            ),

                            SizedBox(height: 5),

                            Text(
                              "Instructor: ${course.instructor}",
                              style: AppTextStyles.appDescriptionTextStyle
                                  .copyWith(color: lightGreen),
                            ),

                            SizedBox(height: 20),

                            if (assignments.isNotEmpty) ...[
                              Text(
                                "Assignments",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: assignments.map((assignment) {
                                  return Card(
                                    margin: EdgeInsets.only(bottom: 10),
                                    color: Colors.black12,
                                    child: ListTile(
                                      title: Text(assignment.name),
                                      subtitle: Text(
                                        'Due Date: ${DateFormat('MMM dd, yyyy').format(assignment.dueDate)}',
                                      ),
                                      onTap: () {
                                        GoRouter.of(context).push(
                                          '/single-assignment',
                                          extra: assignment,
                                        );
                                      },
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],

                            SizedBox(height: 20),

                            // notes
                            if (notes.isNotEmpty) ...[
                              Text(
                                "Notes",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: notes.map((note) {
                                  return Card(
                                    margin: EdgeInsets.only(bottom: 10),
                                    color: Colors.black12,
                                    child: ListTile(
                                      title: Text(note.title),
                                      subtitle: Text(
                                        "Section: ${note.sectionName}",
                                      ),
                                      onTap: () {
                                        GoRouter.of(context)
                                            .push('/single-note', extra: note);
                                      },
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
