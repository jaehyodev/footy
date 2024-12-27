import 'package:flutter/material.dart';
import 'package:frontend/screens/following/widgets/following_search.dart';

void showSearchModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        insetPadding: const EdgeInsets.all(16.0), // Dialog 여백 설정
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0), // Dialog 모서리 둥글게
        ),
        child: const FollowingSearch(),
      );
    },
  );
}
