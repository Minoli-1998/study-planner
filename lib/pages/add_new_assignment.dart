import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_planner/constants/app_text_styles.dart';
import 'package:study_planner/models/assignment_model.dart';
import 'package:study_planner/models/course_model.dart';
import 'package:study_planner/services/database/assignment_service.dart';
import 'package:study_planner/utils/utils_functions.dart';
import 'package:study_planner/widgets/custom_app_button.dart';
import 'package:study_planner/widgets/custom_input_field.dart';

class AddNewAssignment extends StatelessWidget {
  final Course course;
  AddNewAssignment({super.key, required this.course}) {
    _selectedDate.value = DateTime.now();
    _selectedTime.value = TimeOfDay.now();
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _assignmentNameController =
      TextEditingController();
  final TextEditingController _assignmentDescriptionController =
      TextEditingController();
  final TextEditingController _assignmentDurationController =
      TextEditingController();

  final ValueNotifier<DateTime> _selectedDate = ValueNotifier<DateTime>(
    DateTime.now(),
  );
  final ValueNotifier<TimeOfDay> _selectedTime = ValueNotifier<TimeOfDay>(
    TimeOfDay.now(),
  );

  // methods
  Future<void> _selectDatePicker(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedDate.value) {
      _selectedDate.value = pickedDate;
    }
  }

  Future<void> _selectTimePicker(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != _selectedTime.value) {
      _selectedTime.value = pickedTime;
    }
  }

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        final Assignment assignment = Assignment(
          id: "",
          name: _assignmentNameController.text,
          description: _assignmentDescriptionController.text,
          duration: _assignmentDurationController.text,
          dueDate: _selectedDate.value,
          dueTime: _selectedTime.value,
        );

        await AssignmentService().createAssignment(course.id, assignment);

        if (context.mounted) {
          displaySnackbar(context: context, message: "Assignemnt added");
        }

        Future.delayed(Duration(seconds: 2));

        GoRouter.of(context).go('/');
      } catch (error) {
        print(error);
        if (context.mounted) {
          displaySnackbar(
            context: context,
            message: "Error in adding new assignment",
          );
        }
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
                "Add New Assignemnt",
                style: AppTextStyles.appHeadingTextStyle,
              ),

              SizedBox(height: 10),

              Text(
                "Fill in the details below to add a new assignment. And start managing your study planner",
                style: AppTextStyles.appDescriptionTextStyle,
              ),

              SizedBox(height: 20),

              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomInputField(
                      controller: _assignmentNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter the assignment name";
                        }
                        return null;
                      },
                      label: "Assignment Name",
                    ),

                    CustomInputField(
                      controller: _assignmentDescriptionController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter the assignment description";
                        }
                        return null;
                      },
                      label: "Assignment Description",
                    ),

                    CustomInputField(
                      controller: _assignmentDurationController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter the assignment duration";
                        }
                        return null;
                      },
                      label: "Duration (e.g. 1 Hour)",
                    ),

                    Divider(),

                    Text(
                      "Due Date and Time",
                      style: AppTextStyles.appDescriptionTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),

                    SizedBox(height: 20),

                    ValueListenableBuilder<DateTime>(
                      valueListenable: _selectedDate,
                      builder: (BuildContext context, value, Widget? child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Date: ${_selectedDate.value.year}-${_selectedDate.value.month}-${_selectedDate.value.day}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),

                            IconButton(
                              onPressed: () async {
                                await _selectDatePicker(context);
                              },
                              icon: Icon(Icons.calendar_today),
                            ),
                          ],
                        );
                      },
                    ),

                    SizedBox(height: 20),

                    ValueListenableBuilder<TimeOfDay>(
                      valueListenable: _selectedTime,
                      builder: (context, value, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Time: ${_selectedTime.value.format(context)}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),

                            IconButton(
                              onPressed: () async {
                                await _selectTimePicker(context);
                              },
                              icon: Icon(Icons.access_time),
                            ),
                          ],
                        );
                      },
                    ),

                    SizedBox(height: 30),

                    CustomAppButton(
                      onPressed: () {
                        _submitForm(context);
                      },
                      buttonText: "Add Assignment",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
