import 'package:flutter/material.dart';
import 'package:simple_breakfest_flutter_project/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of    application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Breakfest',
      home: Home(),
    );
  }
}
