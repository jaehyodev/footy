import 'package:flutter/material.dart';
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

  // 초기 뉴스 데이터 로드
  Future<void> _fetchInitialNews() async {
    setState(() {
      _isLoading = true;
    });

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
  }

  // sortOption이 변경될 때마다 리스트를 갱신
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // 예를 들어, sortOption 값이 변경되었을 때
    final sortOption = Provider.of<NewsProvider>(context);
    // sortOption 값이 변경되었을 때만 리스트 갱신
    if (_previousSortOption != sortOption.sortBy) {
      // 이전 값과 현재 값이 다르면
      setState(() {
        _news = []; // 리스트를 초기화
        _page = 1; // 페이지 초기화
      });
      _fetchInitialNews(); // 초기 뉴스 데이터 다시 로드
      // 상태값이 변경되었을 때 리스트를 제일 위로 올립니다.
      _scrollController.jumpTo(0); // 스크롤을 맨 위로 이동
      _previousSortOption = sortOption.sortBy; // 이전 값 업데이트
    }
  }

  // 스크롤 시 뉴스 로드
  Future<void> _fetchMoreNews() async {
    setState(() {
      _isLoading = true;
    });

    _page++;

    // 이미 Provider로부터 sortBy 값 가져오므로 상태 변경은 불필요
    final sortOption = Provider.of<NewsProvider>(context, listen: false);
    final sortBy = sortOption.sortBy;

    final List<Map<String, dynamic>> fetchedNews =
        await NewsService.fetchNews(_page, _pageSize, sortBy);
    setState(() {
      _news.addAll(fetchedNews);
      _isLoading = false;
      _hasMore = fetchedNews.length == _pageSize;
    });
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
        itemCount: _news.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < _news.length) {
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
                  // SnackBar를 표시하기 전에 setState로 Context의 유효성을 보장
                  // setState는 위젯 트리가 활성 상태일 때만 호출할 수 있으므로,
                  // mounted를 통해 위젯이 아직 화면에 나타나 있는지 확인
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
          } else {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            );
          }
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
