import 'package:flutter/material.dart';

import 'package:frontend/screens/news/widgets/news_list.dart';
import 'package:frontend/screens/news/widgets/news_sort_option.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  NewsScreenState createState() => NewsScreenState();
}

class NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        NewsSortOption(),
        NewsList(),
      ],
    );
  }
}
