import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram/UI/Screens/HomeScreen.dart';
import 'package:instagram/UI/Screens/Login_Screen.dart';
import 'package:instagram/UI/Screens/editProfile.dart';
import 'package:instagram/UI/Screens/profileScreen.dart';
import 'package:instagram/data/services/Notification_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Supabase.initialize(
    url: "https://oeynmdxsjywembkyshgl.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9leW5tZHhzanl3ZW1ia3lzaGdsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDIxNzI2NTIsImV4cCI6MjA1Nzc0ODY1Mn0.zMh10nb9lk4Bcy-jMnhB_zYYE51TV4yF0XPDy3T0gcA",
  );

  // Initialize notification service
  NotificationService().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const EditProfile(),
      // home: user != null
      //     ? const HomeScreen()
      //     : LoginScreen(), // يمكن تغييرها إلى HomeScreen حسب الحاجة
    );
  }
}
