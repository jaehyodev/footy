import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './providers/league_provider.dart';
import './providers/date_provider.dart';
import 'theme/style.dart' as style;
import './screens/home/home_screen.dart';
import './screens/league/league_screen.dart'; // 예시로 홈 화면
import './widgets/custom_app_bar.dart'; // 커스텀 앱바
import './widgets/bottom_nav_bar.dart'; // 커스텀 바텀 네비게이션 바

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
        theme: style.theme,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String appName = "MatchDay";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(), // 공통 앱바
      body: Padding(
        padding: style.bodyPadding, // bodyPadding을 적용
        child: HomeScreen(), // 현재 화면이 HomeScreen으로 설정
      ),
      bottomNavigationBar: BottomNavBar(), // 공통 바텀 네비게이션 바
    );
  }
}
