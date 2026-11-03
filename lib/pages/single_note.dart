import 'package:flutter/material.dart';
import 'package:study_planner/models/note_model.dart';

class SingleNote extends StatelessWidget {
  final Note note;
  const SingleNote({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${note.title}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              note.description,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            const Text(
              'Section Name:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              note.sectionName,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            const Text(
              'References Books:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              note.referenceBook,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            const Divider(),
            // Display the image if it exists show a loading indicator till the image is loaded
            const Text(
              'Your Note Images',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (note.imagePath != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Image.network(note.imagePath!, width: 300),
              )
            else
              const Text("No images included"),
          ],
        ),
      ),
    );
  }
}
