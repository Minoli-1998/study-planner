import 'package:go_router/go_router.dart';
import 'package:study_planner/pages/add_new_course_page.dart';
import 'package:study_planner/pages/error_page.dart';
import 'package:study_planner/pages/home_page.dart';

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
    ],
  );
}
