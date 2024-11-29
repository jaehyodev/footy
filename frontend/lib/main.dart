import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './data/constants.dart';
import './providers/league_provider.dart';
import './screens/home/home_screen.dart';
import './widgets/custom_app_bar.dart';
import './widgets/bottom_nav_bar.dart';
import './themes/style.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LeagueProvider()),
      ],
      child: MaterialApp(
        home: const MyApp(),
        theme: theme,
      ),
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
      body: Padding(
        padding: bodyPadding, // bodyPadding을 적용
        child: HomeScreen(), // 현재 화면이 HomeScreen으로 설정
      ),
      bottomNavigationBar: BottomNavBar(), // 공통 바텀 네비게이션 바
    );
  }
}
