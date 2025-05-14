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
  String? _fcmToken;

  @override
  void initState() {
    super.initState();
    notificationService.init();
    _getUserToken();
  }

  void _getUserToken() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String? token = await firebaseMessaging.getToken();
    setState(() {
      _fcmToken = token;
    });
    print('User Token ================== $token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Test Notifications"),
            const SizedBox(height: 16),
            SelectableText(
              _fcmToken != null ? 'FCM Token:\n$_fcmToken' : 'Fetching FCM Token...',
            ),
          ],
        ),
      ),
    );
  }
}
