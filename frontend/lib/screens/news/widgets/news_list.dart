import 'package:flutter/material.dart';
import 'package:frontend/utils/loader_overlay.dart';
import 'package:frontend/utils/time_utils.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:frontend/providers/news_provider.dart';
import 'package:frontend/services/news_service.dart';

class NewsList extends StatefulWidget {
  const NewsList({super.key});

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  final ScrollController _scrollController = ScrollController();

  List<Map<String, dynamic>> _news = [];
  int _page = 1;
  final int _pageSize = 10;
  bool _isLoading = false;
  bool _hasMore = true;
  String? _previousSortOption;

  @override
  void initState() {
    super.initState();
    _fetchInitialNews();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoading &&
          _hasMore) {
        _fetchMoreNews();
      }
    });
  }

  Future<void> _fetchInitialNews() async {
    LoaderOverlay.show(context); // 로더 표시
    try {
      final sortOption = Provider.of<NewsProvider>(context, listen: false);
      final sortBy = sortOption.sortBy;
      _previousSortOption = sortOption.sortBy;

      final List<Map<String, dynamic>> fetchedNews =
          await NewsService.fetchNews(_page, _pageSize, sortBy);

      setState(() {
        _news = fetchedNews;
        _isLoading = false;
        _hasMore = fetchedNews.length == _pageSize;
      });
    } catch (e) {
      // 에러 처리
    } finally {
      LoaderOverlay.hide(); // 로더 숨김
    }
  }

  Future<void> _fetchMoreNews() async {
    LoaderOverlay.show(context); // 로더 표시
    try {
      _page++;
      final sortOption = Provider.of<NewsProvider>(context, listen: false);
      final sortBy = sortOption.sortBy;

      final List<Map<String, dynamic>> fetchedNews =
          await NewsService.fetchNews(_page, _pageSize, sortBy);

      setState(() {
        _news.addAll(fetchedNews);
        _isLoading = false;
        _hasMore = fetchedNews.length == _pageSize;
      });
    } catch (e) {
      // 에러 처리
    } finally {
      LoaderOverlay.hide(); // 로더 숨김
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final sortOption = Provider.of<NewsProvider>(context);
    if (_previousSortOption != sortOption.sortBy) {
      setState(() {
        _news = [];
        _page = 1;
      });
      _fetchInitialNews();
      _scrollController.jumpTo(0);
      _previousSortOption = sortOption.sortBy;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 16),
        controller: _scrollController,
        itemCount: _news.length,
        itemBuilder: (context, index) {
          final newsItem = _news[index];
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              width: 120,
              height: 80,
              color: Colors.grey,
              child: newsItem['urlToImage'] != null
                  ? Image.network(
                      newsItem['urlToImage'],
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.image_not_supported),
            ),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  newsItem['title'] ?? '제목 없음',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const Gap(4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      newsItem['source']['name'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF757575),
                      ),
                    ),
                    Text(
                      TimeUtils.timeAgo(
                          DateTime.parse(newsItem['publishedAt'])),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF757575),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            onTap: () async {
              final url = newsItem['url'];

              if (url != null && await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              } else {
                if (mounted) {
                  setState(() {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('뉴스 링크를 찾을 수 없습니다.'),
                      ),
                    );
                  });
                }
              }
            },
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            color: Color(0xFFE0E0E0),
            thickness: 0.5,
            height: 0.5,
          );
        },
      ),
    );
  }
}
