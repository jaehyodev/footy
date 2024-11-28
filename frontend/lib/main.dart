import 'package:flutter/material.dart';
import './data/constants.dart';

void main() async {
  runApp(
    const MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String appName = Constants.appName;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text(
        "body",
      ),
    );
  }
}
