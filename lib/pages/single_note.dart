import 'package:flutter/material.dart';
import 'package:study_planner/constants/app_text_styles.dart';
import 'package:study_planner/models/note_model.dart';

class SingleNote extends StatelessWidget {
  final Note note;
  const SingleNote({super.key, required this.note});

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
                "Title: ${note.title}",
                style: AppTextStyles.appHeadingTextStyle,
              ),

              SizedBox(height: 20),

              Text("Description", style: AppTextStyles.appHeadingTextStyle),

              SizedBox(height: 10),

              Text(
                note.description,
                style: AppTextStyles.appDescriptionTextStyle,
              ),

              SizedBox(height: 15),

              Text("Section Name:", style: AppTextStyles.appHeadingTextStyle),

              SizedBox(height: 5),

              Text(
                note.sectionName,
                style: AppTextStyles.appDescriptionTextStyle,
              ),

              SizedBox(height: 15),

              Text("Reference Book", style: AppTextStyles.appHeadingTextStyle),

              SizedBox(height: 5),

              Text(
                note.referenceBook,
                style: AppTextStyles.appDescriptionTextStyle,
              ),

              SizedBox(height: 15),

              Divider(),

              // if (note.imagePath!.isNotEmpty) ...[
              //   Image.file(File(note.imagePath!), height: 150, fit: BoxFit.cover),
              // ],
            ],
          ),
        ),
      ),
    );
  }
}
