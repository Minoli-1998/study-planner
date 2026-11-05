import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:study_planner/constants/app_text_styles.dart';
import 'package:study_planner/constants/colors.dart';
import 'package:study_planner/services/database/notification_service.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications", style: AppTextStyles.appHeadingTextStyle),
      ),

      body: StreamBuilder(
        stream: NotificationService().fetchNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error : ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No overdue assignments to display"));
          } else {
            return Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final notification = snapshot.data![index];

                  return Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification.assignmentName,
                          style: AppTextStyles.appHeadingTextStyle.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        Card(
                          color: primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Course: ${notification.courseName}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),

                                SizedBox(height: 5),

                                Text(
                                  "Assignment: ${notification.assignmentName}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),

                                SizedBox(height: 5),

                                Text(
                                  "Due date: ${DateFormat.yMMMd().format(notification.dueDate)}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),

                                SizedBox(height: 5),

                                Text(
                                  "Time: ${DateTime.now().difference(notification.dueDate).inHours} hours",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
