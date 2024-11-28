import 'package:flutter/material.dart';
import './data/constants.dart';
import './widgets/custom_app_bar.dart'; // 커스텀 앱바
import './widgets/bottom_nav_bar.dart';

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
      appBar: CustomAppBar(), // 공통 앱바
      body: Text(
        "body",
      ),
      bottomNavigationBar: BottomNavBar(), // 공통 바텀 네비게이션 바
    );
  }
}
