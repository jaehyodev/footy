import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'package:frontend/data/constants.dart';
import 'package:frontend/providers/date_provider.dart';
import 'package:frontend/providers/league_provider.dart';
import 'package:frontend/screens/following/following_screen.dart';
import 'package:frontend/screens/home/home_screen.dart';
import 'package:frontend/screens/league/league_screen.dart';
import 'package:frontend/screens/news/news_screen.dart';
import 'package:frontend/screens/settings/settings_screen.dart';
import 'package:frontend/themes/style.dart';
import 'package:frontend/widgets/custom_app_bar.dart';
import 'package:frontend/widgets/bottom_nav_bar.dart';

void main() async {
  await dotenv.load(fileName: 'assets/config/.env');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LeagueProvider()),
        ChangeNotifierProvider(create: (_) => DateProvider()),
      ],
      child: MaterialApp(
        home: const MyApp(),
        theme: theme,
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String appName = Constants.appName;

  // 선택된 화면의 인덱스
  int _selectedIndex = 0;

  // 화면을 전환하는 함수
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // 각 화면에 해당하는 위젯
  final List<Widget> _screens = [
    const HomeScreen(),
    const NewsScreen(),
    const LeagueScreen(),
    const FollowingScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: bodyPadding,
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
