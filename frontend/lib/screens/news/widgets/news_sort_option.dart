import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import 'package:frontend/providers/news_provider.dart';

class NewsSortOption extends StatelessWidget {
  const NewsSortOption({super.key});

  @override
  Widget build(BuildContext context) {
    final newsSortOption = Provider.of<NewsProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 16.0), // 위쪽에만 패딩
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              newsSortOption.setSortBy('publishedAt'); // 최신순
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: newsSortOption.sortBy == 'publishedAt'
                          ? Colors.blue
                          : Colors.black,
                    ),
                  ),
                ),
                Text(
                  '최신순',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: newsSortOption.sortBy == 'publishedAt'
                        ? Colors.blue
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16), // 두 항목 사이 간격
          GestureDetector(
            onTap: () {
              newsSortOption.setSortBy('popularity'); // 인기도순
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: newsSortOption.sortBy == 'popularity'
                          ? Colors.blue
                          : Colors.black,
                    ),
                  ),
                ),
                Text(
                  '인기순',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: newsSortOption.sortBy == 'popularity'
                        ? Colors.blue
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
