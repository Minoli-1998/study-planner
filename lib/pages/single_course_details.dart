import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_planner/constants/app_text_styles.dart';
import 'package:study_planner/models/course_model.dart';
import 'package:study_planner/services/course_service.dart';
import 'package:study_planner/utils/utils_functions.dart';
import 'package:study_planner/widgets/add_assignment_card.dart';
import 'package:study_planner/widgets/custom_app_button.dart';

class SingleCourseDetails extends StatelessWidget {
  final Course course;
  const SingleCourseDetails({super.key, required this.course});

  void _deleteCourse(String courseId, BuildContext context) async {
    try {
      await CourseService().deleteCourse(courseId);

      if (context.mounted) {
        displaySnackbar(context: context, message: "Course deleted");
      }

      Future.delayed(Duration(seconds: 2));

      GoRouter.of(context).go("/");
    } catch (error) {
      if (context.mounted) {
        displaySnackbar(
          context: context,
          message: "Error in deleting course : $error",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course.name,
                style: AppTextStyles.appHeadingTextStyle.copyWith(fontSize: 18),
              ),

              SizedBox(height: 10),

              Text(
                "Instructor: ${course.instructor}",
                style: AppTextStyles.appDescriptionTextStyle,
              ),

              SizedBox(height: 10),

              Text(
                "Duration: ${course.duration}",
                style: AppTextStyles.appDescriptionTextStyle,
              ),

              SizedBox(height: 10),

              Text(
                "Schedule: ${course.schedule}",
                style: AppTextStyles.appDescriptionTextStyle,
              ),

              SizedBox(height: 30),

              Text(
                "Description",
                style: AppTextStyles.appHeadingTextStyle.copyWith(fontSize: 18),
              ),

              SizedBox(height: 20),

              Text(
                course.description,
                style: AppTextStyles.appDescriptionTextStyle,
              ),

              SizedBox(height: 30),

              // cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // assignment
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context)
                          .push('/new-assignment', extra: course);
                    },
                    child: AddAssignmentCard(
                      title: "Add Assignment",
                      description: "Add a new assignment to this course and set a deadline. Also you can add a description to the assignment.",
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push('/new-note', extra: course);
                    },
                    child: AddAssignmentCard(
                      title: "Add Notes",
                      description: "Add notes to this course to help you remember important points and topics. And you can also add images and links.",
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              CustomAppButton(
                onPressed: () => _deleteCourse(course.id, context),
                buttonText: "Delete Course",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
