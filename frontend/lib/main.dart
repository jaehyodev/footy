import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import './data/constants.dart';
import './providers/league_provider.dart';
import './providers/date_provider.dart';
import './screens/home/home_screen.dart';
import './widgets/custom_app_bar.dart';
import './widgets/bottom_nav_bar.dart';
import './themes/style.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String appName = Constants.appName;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: bodyPadding,
        child: HomeScreen(),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
