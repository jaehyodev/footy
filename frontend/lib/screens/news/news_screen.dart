import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  NewsScreenState createState() => NewsScreenState();
}

class NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('News Screen'));
  }
}
