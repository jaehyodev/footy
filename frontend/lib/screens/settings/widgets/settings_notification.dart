import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsNotification extends StatefulWidget {
  const SettingsNotification({super.key});

  @override
  State<SettingsNotification> createState() => _SettingsNotificationState();
}

class _SettingsNotificationState extends State<SettingsNotification> {
  bool _matchNotification = false;
  bool _scoreNotification = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  // 로컬 저장소에서 설정 값 불러오기
  _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _matchNotification = prefs.getBool('matchStartEndNotification') ?? false;
      _scoreNotification = prefs.getBool('scoreNotification') ?? false;
    });
  }

  // 로컬 저장소에 설정 값 저장하기
  _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('matchNotification', _matchNotification);
    prefs.setBool('scoreNotification', _scoreNotification);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(16),

        // 알림 섹션을 묶은 컨테이너
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 알림 아이콘과 텍스트
              const Row(
                children: [
                  Icon(
                    Icons.notifications,
                    size: 24,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 8),
                  Text(
                    '알림',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Gap(16),
              // 경기 시작/종료 알림 토글버튼
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '경기 시작/종료 알림',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  CupertinoSwitch(
                    value: _matchNotification,
                    onChanged: (bool value) {
                      setState(() {
                        _matchNotification = value;
                      });
                      _saveSettings();
                    },
                    trackColor: CupertinoColors.systemGrey,
                    activeColor: CupertinoColors.activeBlue,
                  ),
                ],
              ),
              const Gap(12),
              // 경기 스코어 알림 토글버튼
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '경기 스코어 알림',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  CupertinoSwitch(
                    value: _scoreNotification,
                    onChanged: (bool value) {
                      setState(() {
                        _scoreNotification = value;
                      });
                      _saveSettings();
                    },
                    trackColor: CupertinoColors.systemGrey,
                    activeColor: CupertinoColors.activeBlue,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
