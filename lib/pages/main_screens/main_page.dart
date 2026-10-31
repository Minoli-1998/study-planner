import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_planner/constants/app_text_styles.dart';
import 'package:study_planner/constants/colors.dart';
import 'package:study_planner/models/course_model.dart';
import 'package:study_planner/services/course_service.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Study Planner",
          style: TextStyle(
            color: darkGreen,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),

        actions: [
          ElevatedButton(
            onPressed: () {
              GoRouter.of(context).push('/add-new-course');
            },
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(primaryColor),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Icon(Icons.add, color: Colors.white),
                  SizedBox(width: 15),
                  Text("Add Course", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        ],

        actionsPadding: EdgeInsets.only(right: 16),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your study planner helps you to keep track of your study progress and manage your time effectively.",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),

              SizedBox(height: 20),

              Text(
                "Courses",
                style: AppTextStyles.appHeadingTextStyle.copyWith(fontSize: 18),
              ),
              Text(
                "Your running subjects",
                style: AppTextStyles.appDescriptionTextStyle,
              ),

              SizedBox(height: 10),

              // stream builder
              StreamBuilder(
                stream: CourseService().getCourses(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Has an error"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("No courses to display"));
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Course course = snapshot.data![index];

                        return Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 20,
                          ),
                          margin: EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            color: lightGreen,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                course.name,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Text(
                                course.description,
                                style: AppTextStyles.appDescriptionTextStyle
                                    .copyWith(color: Colors.black),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
