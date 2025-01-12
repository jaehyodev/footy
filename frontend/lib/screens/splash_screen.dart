import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/main.dart';

import 'package:frontend/screens/home/home_screen.dart';
import 'package:frontend/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  Future<void> _checkUserStatus() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    // 빌드 완료 후 네비게이션 처리
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (currentUser != null) {
        // 사용자가 로그인 되어 있으면 메인 화면으로 이동
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MyApp()),
          );
        }
      } else {
        // 로그인이 되어 있지 않으면 로그인 화면으로 이동
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/icons/logo/app_icon.png',
          width: 120,
          height: 120,
        ),
      ),
    );
  }
}
