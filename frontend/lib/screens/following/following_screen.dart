import 'package:flutter/material.dart';
import 'package:frontend/screens/following/widgets/following_list.dart';

class FollowingScreen extends StatefulWidget {
  const FollowingScreen({super.key});

  @override
  FollowingScreenState createState() => FollowingScreenState();
}

class FollowingScreenState extends State<FollowingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        FollowingList(),
      ],
    );
  }
}
