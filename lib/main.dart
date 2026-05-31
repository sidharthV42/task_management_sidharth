import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:task_management/screens/login_screen.dart';
import 'package:task_management/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.openBox("myBox"); // For tasks
  await Hive.openBox("authBox"); // For authentication
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Task Manager',
      home: _getHomeScreen(),
    );
  }

  // Check if user is logged in
  Widget _getHomeScreen() {
    final authBox = Hive.box("authBox");
    bool isLoggedIn = authBox.get("isLoggedIn", defaultValue: false);
    
    if (isLoggedIn) {
      return const HomeScreen();
    } else {
      return LoginScreen();
    }
  }
}
