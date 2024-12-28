import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  static const String _apiUrl = 'https://newsapi.org/v2'; // API URL
  static const String _apiKey = '6b75be02115b456d9c09b7a454e6637b'; // API 키

  static Future<List<Map<String, dynamic>>> fetchNews(
      int page, int pageSize, String sortBy) async {
    try {
      // HTTP 요청을 보내고 응답을 받음
      final http.Response response = await http.get(
        Uri.parse(
            "$_apiUrl/everything?domains=skysports.com&q=football&page=$page&pageSize=$pageSize&sortBy=$sortBy&apiKey=$_apiKey"),
        headers: {'X-Auth-Token': _apiKey},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        print(data);
        return List<Map<String, dynamic>>.from(data['articles']);
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      print('Error fetching news: $e');
      return [];
    }
  }
}
