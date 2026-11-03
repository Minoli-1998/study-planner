import 'package:flutter/material.dart';
import 'package:study_planner/constants/app_text_styles.dart';
import 'package:study_planner/models/assignment_model.dart';

class SingleAssignment extends StatelessWidget {
  final Assignment assignment;
  const SingleAssignment({super.key, required this.assignment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              assignment.name,
              style: AppTextStyles.appHeadingTextStyle.copyWith(fontSize: 16),
            ),

            SizedBox(height: 20),

            Text(
              assignment.description,
              style: AppTextStyles.appDescriptionTextStyle,
            ),

            SizedBox(height: 5),

            Text(
              'Due Date: ${assignment.dueDate}',
              style: AppTextStyles.appDescriptionTextStyle,
            ),

            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
