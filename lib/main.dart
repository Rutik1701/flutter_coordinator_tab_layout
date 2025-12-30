import 'package:coordinator_tab_layout/Coordinator%20TabLayout/coordinator_tab_layout.dart';
import 'package:coordinator_tab_layout/Coordinator%20TabLayout/demo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DemoScreen(),
    );
  }
}

