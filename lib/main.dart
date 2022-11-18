import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:to_do_task/main_screen.dart';
import 'package:to_do_task/themedata.dart';

Future<void> main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Task',
      debugShowCheckedModeBanner: false,
      theme: ThemeClass.themeData,
      home: const MainScreen(),
    );
  }
}
