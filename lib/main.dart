import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:task_management/screens/login_screen.dart';
import 'package:task_management/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.openBox("myBox"); // For tasks
  await Hive.openBox("authBox"); // For authentication
  await Hive.openBox("usersBox"); // For user credentials
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Box authBox;

  @override
  void initState() {
    super.initState();
    authBox = Hive.box("authBox");
    // Listen to changes in authBox
    authBox.listenable().addListener(_updateUI);
  }

  void _updateUI() {
    setState(() {});
  }

  @override
  void dispose() {
    authBox.listenable().removeListener(_updateUI);
    super.dispose();
  }

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
    bool isLoggedIn = authBox.get("isLoggedIn", defaultValue: false);
    
    if (isLoggedIn) {
      return const HomeScreen();
    } else {
      return LoginScreen();
    }
  }
}
