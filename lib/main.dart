import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:task_management/screens/login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await Hive.openBox("myBox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {


  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:!true,
      title: 'Task Manager',
      home: LoginScreen(),
    );
  }
}


