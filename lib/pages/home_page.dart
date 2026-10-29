import 'package:flutter/material.dart';
import 'package:study_planner/constants/colors.dart';
import 'package:study_planner/pages/main_screens/assignments_page.dart';
import 'package:study_planner/pages/main_screens/courses_page.dart';
import 'package:study_planner/pages/main_screens/main_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // fields
  int _pageIndex = 0;
  final _pages = [MainPage(), CoursesPage(), AssignmentsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: "Courses"),
          BottomNavigationBarItem(
            icon: Icon(Icons.document_scanner),
            label: "Assignments",
          ),
        ],
      ),

      body: _pages[_pageIndex],
    );
  }
}
