import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/material.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;

class SettingsLogout extends StatefulWidget {
  const SettingsLogout({super.key});

  @override
  _SettingsLogoutState createState() => _SettingsLogoutState();
}

class _SettingsLogoutState extends State<SettingsLogout> {
  void _logout() async {
    await auth.signOut();
  }

  // 카카오 로그아웃 함수
  Future<void> logoutFromKakao() async {
    try {
      // Firebase에서 로그인된 사용자 정보 확인
      firebase.User? currentUser = firebase.FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        // 사용자가 카카오로 로그인했는지 확인
        if (currentUser.uid.substring(0, 5) == 'kakao') {
          // 카카오 로그아웃 처리
          await kakao.UserApi.instance.logout();
          print('카카오 로그아웃 성공');
        }
      } else {
        print('로그아웃 실패, 로그인 상태가 아닙니다.');
      }

      await firebase.FirebaseAuth.instance.signOut();
      print('로그아웃 성공');

      // 로그아웃 성공 후 로그인 화면으로 이동
      if (mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
      }
    } catch (error) {
      print('로그아웃 실패, SDK에서 토큰 삭제 $error');

      // 로그아웃 실패 시 다이얼로그로 오류 메시지 띄우기
      if (mounted) {
        // 위젯이 여전히 화면에 있을 경우에만 다이얼로그 표시
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('로그아웃 실패'),
              content: const Text('로그아웃에 실패했습니다. 다시 시도해주세요.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('확인'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: logoutFromKakao,
      child: Card(
        margin: const EdgeInsets.only(top: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        elevation: 2,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(7),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.exit_to_app, color: Colors.white, size: 30),
              SizedBox(width: 10),
              Text(
                '로그아웃',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
