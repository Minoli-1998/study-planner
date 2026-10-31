import 'package:flutter/material.dart';
import 'package:study_planner/constants/app_text_styles.dart';
import 'package:study_planner/models/course_model.dart';

class AddNewAssignment extends StatelessWidget {
  final Course course;
  const AddNewAssignment({super.key, required this.course});

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
                "Add New Assignemnt",
                style: AppTextStyles.appHeadingTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
