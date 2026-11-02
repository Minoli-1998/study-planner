import 'dart:io';

class Note {
  final String id;
  final String title;
  final String description;
  final String sectionName;
  final String referenceBook;
  final File? imageData;
  final String? imagePath;

  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.sectionName,
    required this.referenceBook,
    this.imageData,
    this.imagePath,
  });

  // merhod to convert from json to dart
  factory Note.fromJson(Map<String, dynamic> data) {
    return Note(
      id: data['id'] ?? "",
      title: data['title'] ?? "",
      description: data['description'] ?? "",
      sectionName: data['sectionName'] ?? "",
      referenceBook: data['referenceBook'] ?? "",
      imageData: data['imageData'],
      imagePath: data['imagePath'],
    );
  }

  // convert to json
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'sectionName': sectionName,
      'referenceBook': referenceBook,
      'imageData': imageData,
      'imagePath': imagePath,
    };
  }
}
