import 'package:go_router/go_router.dart';
import 'package:study_planner/models/course_model.dart';
import 'package:study_planner/pages/add_new_assignment.dart';
import 'package:study_planner/pages/add_new_course_page.dart';
import 'package:study_planner/pages/add_new_note.dart';
import 'package:study_planner/pages/error_page.dart';
import 'package:study_planner/pages/home_page.dart';
import 'package:study_planner/pages/single_course_details.dart';

class RouterClass {
  final router = GoRouter(
    initialLocation: "/",
    errorBuilder: (context, state) {
      return ErrorPage();
    },
    routes: [
      // home page
      GoRoute(
        path: '/',
        name: "Home",
        builder: (context, state) {
          return HomePage();
        },
      ),

      // add new course
      GoRoute(
        path: '/add-new-course',
        name: "Add new course",
        builder: (context, state) {
          return AddNewCoursePage();
        },
      ),

      // single course page
      GoRoute(
        path: '/single-course',
        name: "Single course",
        builder: (context, state) {
          final course = state.extra as Course;
          return SingleCourseDetails(course: course);
        },
      ),

      // add new assignment page
      GoRoute(
        path: '/new-assignment',
        name: "New assignment",
        builder: (context, state) {
          final course = state.extra as Course;
          return AddNewAssignment(course: course);
        },
      ),

      // add new note page
      GoRoute(
        path: '/new-note',
        name: "New note",
        builder: (context, state) {
          final course = state.extra as Course;
          return AddNewNote(course: course);
        },
      ),
    ],
  );
}
