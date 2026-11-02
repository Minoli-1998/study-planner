import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:study_planner/constants/app_text_styles.dart';
import 'package:study_planner/models/course_model.dart';
import 'package:study_planner/models/note_model.dart';
import 'package:study_planner/services/database/note_service.dart';
import 'package:study_planner/utils/utils_functions.dart';
import 'package:study_planner/widgets/custom_app_button.dart';
import 'package:study_planner/widgets/custom_input_field.dart';

class AddNewNote extends StatefulWidget {
  final Course course;
  const AddNewNote({super.key, required this.course});

  @override
  State<AddNewNote> createState() => _AddNewNoteState();
}

class _AddNewNoteState extends State<AddNewNote> {
  // fields
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _noteDescriptionController =
      TextEditingController();
  final TextEditingController _sectionNameController = TextEditingController();
  final TextEditingController _referenceBooksController =
      TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();

  XFile? _selectedImage;

  // method to pick image from gallery
  Future<void> _pickImage() async {
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = image;
    });
  }

  // methods
  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        // create new note
        final Note note = Note(
          id: "",
          title: _noteTitleController.text,
          description: _noteDescriptionController.text,
          sectionName: _sectionNameController.text,
          referenceBook: _referenceBooksController.text,
          imageData: _selectedImage != null ? File(_selectedImage!.path) : null,
        );

        await NoteService().createNote(widget.course.id, note);

        if (context.mounted) {
          displaySnackbar(context: context, message: "New note created");
        }

        Future.delayed(Duration(seconds: 2));

        GoRouter.of(context).go('/');
      } catch (error) {
        print(error);

        if (context.mounted) {
          displaySnackbar(
            context: context,
            message: "Error in creating new note",
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
                "Add New Note For Your Course",
                style: AppTextStyles.appHeadingTextStyle,
              ),

              SizedBox(height: 10),

              Text(
                "Fill in the details below to add a new note. And start managing your study planner.",
                style: AppTextStyles.appDescriptionTextStyle,
              ),

              SizedBox(height: 20),

              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomInputField(
                      controller: _noteTitleController,
                      label: "Note Title",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter the note title";
                        }
                        return null;
                      },
                    ),

                    CustomInputField(
                      controller: _noteDescriptionController,
                      label: "Description",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter the note description";
                        }
                        return null;
                      },
                    ),

                    CustomInputField(
                      controller: _sectionNameController,
                      label: "Section Name",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter the section name";
                        }
                        return null;
                      },
                    ),

                    CustomInputField(
                      controller: _referenceBooksController,
                      label: "Reference Books",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter the reference books";
                        }
                        return null;
                      },
                    ),

                    Divider(),

                    SizedBox(height: 10),

                    Text(
                      "Upload Note Image, for better understanding and quick revision",
                      style: AppTextStyles.appDescriptionTextStyle,
                    ),

                    SizedBox(height: 20),

                    CustomAppButton(
                      onPressed: () => _pickImage(),
                      buttonText: "Upload Note Image",
                    ),

                    SizedBox(height: 20),

                    _selectedImage == null
                        ? Text(
                            "No Image Found",
                            style: AppTextStyles.appDescriptionTextStyle,
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Selected Image",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),

                              SizedBox(height: 10),

                              ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(20),
                                child: Image.file(
                                  File(_selectedImage!.path),
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),

                    SizedBox(height: 20),

                    CustomAppButton(
                      onPressed: () => _submitForm(context),
                      buttonText: "Submit Note",
                    ),

                    SizedBox(height: 20),
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
