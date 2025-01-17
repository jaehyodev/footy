import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:frontend/data/constants.dart';
import 'package:frontend/providers/date_provider.dart';
import 'package:frontend/providers/following_provider.dart';
import 'package:frontend/providers/home_league_provider.dart';
import 'package:frontend/providers/league_league_provider.dart';
import 'package:frontend/providers/news_provider.dart';
import 'package:frontend/providers/season_provider.dart';
import 'package:frontend/providers/team_provider.dart';
import 'package:frontend/screens/following/following_screen.dart';
import 'package:frontend/screens/home/home_screen.dart';
import 'package:frontend/screens/league/league_screen.dart';
import 'package:frontend/screens/news/news_screen.dart';
import 'package:frontend/screens/settings/settings_screen.dart';
import 'package:frontend/screens/splash_screen.dart';
import 'package:frontend/themes/style.dart';
import 'package:frontend/utils/modal_utils.dart';
import 'package:frontend/widgets/custom_app_bar.dart';
import 'package:frontend/widgets/bottom_nav_bar.dart';

void main() async {
  await dotenv.load(fileName: 'assets/config/.env');

  // 카카오 로그인
  KakaoSdk.init(
    nativeAppKey: '6396447500839981d03bccc4f916cc25',
    javaScriptAppKey: '8a723f3366fbb924bad1061d78e4884d',
  );

  // 카카오 키 해시 확인
  // print(await KakaoSdk.origin);

  // firebase 초기화
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DateProvider()),
        ChangeNotifierProvider(create: (_) => FollowingProvider()),
        ChangeNotifierProvider(create: (_) => HomeLeagueProvider()),
        ChangeNotifierProvider(create: (_) => LeagueLeagueProvider()),
        ChangeNotifierProvider(create: (_) => NewsProvider()),
        ChangeNotifierProvider(create: (_) => SeasonProvider()),
        ChangeNotifierProvider(create: (_) => TeamProvider()),
      ],
      child: MaterialApp(
        home: const SplashScreen(),
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
  // 앱바 제목
  String _appBarTitle = Constants.appBarTitles[0];
  // 현재 홈 화면인지 여부
  bool _isHomePage = true;

  @override
  void initState() {
    super.initState();
  }

  // 화면 전환
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _appBarTitle = Constants.appBarTitles[index];
      if (index != 0) {
        _isHomePage = false;
      } else {
        _isHomePage = true;
      }
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
        appBar: CustomAppBar(
          title: _appBarTitle,
          isHomePage: _isHomePage,
          actions: _selectedIndex == 3 // FollowingScreen일 때만 추가
              ? [
                  Consumer<FollowingProvider>(
                    builder: (context, provider, _) {
                      return IconButton(
                        icon: Icon(
                          provider.isEditing ? Icons.check : Icons.edit,
                          color: Colors.white,
                        ),
                        onPressed: provider.toggleEditMode,
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () => showSearchModal(context),
                  ),
                ]
              : null,
        ),
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
