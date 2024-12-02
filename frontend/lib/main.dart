import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        theme: AppStyle.theme,
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

  // 마지막으로 뒤로가기 버튼을 누른 시간
  DateTime? currentBackPressTime;

  // 뒤로가기 버튼 동작을 처리하는 메서드
  void _goBack() {
    DateTime now = DateTime.now();

    // 뒤로가기 버튼을 처음 눌렀거나, 마지막으로 누른 지 2초 이상 경과 여부
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      // 현재 시간을 마지막 뒤로가기 버튼울 누른 시간으로 저장
      currentBackPressTime = now;

      // 사용자에게 확인 메시지를 표시
      Fluttertoast.showToast(
        msg: "한 번 더 누르면 앱을 끌 수 있어요.",
      );
    } else {
      // 2초 이내에 다시 뒤로가기 버튼을 누른 경우, 앱 종료
      SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // 기존 뒤로가기 금지
      canPop: false,
      // 뒤로가기 버튼을 누르고, 한 번 더 누르면 앱을 종료
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        _goBack();
      },
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: Padding(
          padding: AppStyle.bodyPadding,
          child: _screens[_selectedIndex],
        ),
        bottomNavigationBar: BottomNavBar(
          selectedIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
