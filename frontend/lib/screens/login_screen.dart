import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/firebase_auth_remote_data_source.dart';
import 'package:frontend/utils/loader_overlay.dart';
import 'package:gap/gap.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:frontend/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';

final auth = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _firebaseAuthDataSource = FirebaseAuthRemoteDataSource();
  kakao.User? user;

  // 이메일 회원가입
  Future _join(String email, String password) async {
    try {
      var result = await auth.createUserWithEmailAndPassword(
        email: "kim@test.com",
        password: "123456",
      );
      result.user?.updateDisplayName('jaehyo');
      print(result.user);
    } catch (e) {
      print(e);
    }
  }

  // 이메일 로그인
  Future _login() async {
    try {
      await auth.signInWithEmailAndPassword(
          email: 'kim@test.com', password: '123456');
    } catch (e) {
      print(e);
    }

    // 로그인 확인
    if (auth.currentUser?.uid == null) {
      // 로그인 요청 로직
    } else {
      // 로그인한 상태 로직
    }
  }

  // 로그인 성공 후 홈 화면으로 이동
  void _navigateToMainPage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const MyApp(),
    ));
  }

  // 카카오 로그인
  Future loginWithKakao() async {
    // 로딩 화면 표시
    LoaderOverlay.show(context);

    try {
      // 카카오톡 설치 여부 확인
      if (await kakao.isKakaoTalkInstalled()) {
        await kakao.UserApi.instance.loginWithKakaoTalk();
      } else {
        await kakao.UserApi.instance.loginWithKakaoAccount();
      }

      // 로그인 후 사용자 정보 확인
      var user = await kakao.UserApi.instance.me();

      final token = await _firebaseAuthDataSource.createCustomToken({
        'uid': user.id.toString(),
        'email': user.kakaoAccount?.email,
      });

      print(user.id.toString());

      print("Custom Token: $token");

      await FirebaseAuth.instance.signInWithCustomToken(token);

      // 로그인 성공 후 홈 화면으로 이동
      _navigateToMainPage();
      print('카카오 로그인 성공');
    } catch (error) {
      print('카카오 로그인 실패: $error');
      if (error is PlatformException && error.code == 'CANCELED') {
        return;
      }
    } finally {
      // 로그인 처리 후 로딩 화면 숨기기
      LoaderOverlay.hide();
    }
  }

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);

    // 로그인 성공 후 홈 화면으로 이동
    _navigateToMainPage();
    print('구글 로그인 성공');
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 로고
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: screenHeight * 0.25),
                child: Image.asset(
                  'assets/icons/logo/app_icon.png',
                  width: 120,
                  height: 120,
                ),
              ),
            ),

            const Gap(20),

            const Text(
              "해외 축구의 모든 정보,\n이제 한 곳에서!",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w900),
            ),

            const Gap(80),

            SocialLoginButton(
              backgroundColor: Colors.yellow,
              text: 'Kakao로 시작하기',
              textColor: Colors.black,
              buttonType: SocialLoginButtonType.generalLogin,
              borderRadius: 8,
              imageWidth: 28,
              imagePath: "assets/images/login/kakao_login_logo.png",
              onPressed: loginWithKakao,
            ),

            const Gap(15),

            SocialLoginButton(
              backgroundColor: Colors.white,
              text: 'Google로 시작하기',
              textColor: Colors.black,
              buttonType: SocialLoginButtonType.generalLogin,
              borderRadius: 8,
              imageWidth: 28,
              imagePath: "assets/images/login/google_login_logo.png",
              onPressed: signInWithGoogle,
            ),
          ],
        ),
      ),
    );
  }
}
