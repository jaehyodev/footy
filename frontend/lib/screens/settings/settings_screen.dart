import 'package:flutter/material.dart';
import 'package:frontend/screens/settings/widgets/settings_logout.dart';
import 'package:frontend/screens/settings/widgets/settings_notification.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SettingsNotification(),
        SettingsLogout(),
      ],
    );
  }
}
