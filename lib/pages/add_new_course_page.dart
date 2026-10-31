import 'package:flutter/material.dart';
import 'package:study_planner/constants/app_text_styles.dart';
import 'package:study_planner/widgets/custom_app_button.dart';
import 'package:study_planner/widgets/custom_input_field.dart';

class AddNewCoursePage extends StatefulWidget {
  const AddNewCoursePage({super.key});

  @override
  State<AddNewCoursePage> createState() => _AddNewCoursePageState();
}

class _AddNewCoursePageState extends State<AddNewCoursePage> {
  @override
  Widget build(BuildContext context) {
    // form key
    final _formKey = GlobalKey<FormState>();

    // feilds controllers
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _descriptionController =
        TextEditingController();
    final TextEditingController _durationController = TextEditingController();
    final TextEditingController _scheduleController = TextEditingController();
    final TextEditingController _instructorController = TextEditingController();

    // submit form method
    void _submitForm(BuildContext context) async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        // course model

        // save course data in firebase

        // clear fields
        _nameController.clear();
        _descriptionController.clear();
        _durationController.clear();
        _scheduleController.clear();
        _instructorController.clear();
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Add New Course", style: AppTextStyles.appHeadingTextStyle),

            SizedBox(height: 10),

            Text(
              "Fill in the details below to ass a new course and start managing your study planner",
              style: AppTextStyles.appDescriptionTextStyle,
            ),

            SizedBox(height: 20),

            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomInputField(
                      controller: _nameController,
                      label: "Course name",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a course name";
                        }
                        return null;
                      },
                    ),

                    CustomInputField(
                      controller: _descriptionController,
                      label: "Course Description",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a course description";
                        }
                        return null;
                      },
                    ),

                    CustomInputField(
                      controller: _durationController,
                      label: "Course Duration",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a course duration";
                        }
                        return null;
                      },
                    ),

                    CustomInputField(
                      controller: _scheduleController,
                      label: "Course Schedule",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a course schedule";
                        }
                        return null;
                      },
                    ),

                    CustomInputField(
                      controller: _instructorController,
                      label: "Course Instructor",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a course instructor";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 20),

                    // submit button
                    CustomAppButton(
                      onPressed: () => _submitForm(context),
                      buttonText: "Add Course",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
