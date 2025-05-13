import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:instagram/data/services/Notification_service.dart';

class NotificationsTest extends StatefulWidget {
  const NotificationsTest({super.key});

  @override
  State<NotificationsTest> createState() => _NotificationsTestState();
}

class _NotificationsTestState extends State<NotificationsTest> {
  NotificationService notificationService = NotificationService();
  void getUserToken() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String? token = await firebaseMessaging.getToken(); //function in firebase
    print('User Token ================== $token');
  }

  // in statefulWidget only >> help to print anything First in screen ..
  @override
  void initState() {
    super.initState();
    notificationService.init();
    getUserToken();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Test Notifications"),
      ),
    );
  }
}
