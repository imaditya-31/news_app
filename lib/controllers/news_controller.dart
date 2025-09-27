import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/constants/api_constant.dart';
import 'package:news_app/models/news_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsController extends GetxController {
  var articles = <NewsModel>[].obs;
  var bookmarks = <NewsModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNews();
    loadBookmarks();
  }

  void fetchNews() async {
    isLoading(true);
    final url = Uri.parse(
        '${ApiConstant.baseUrl}?apikey=${ApiConstant.apiKey}&language=en');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List<NewsModel> temp = [];
        data['results'].forEach((v) {
          temp.add(NewsModel.fromJson(v));
        });
        articles.assignAll(temp);
      }
    } finally {
      isLoading(false);
    }
  }

  void addBookmark(NewsModel article) {
    bookmarks.add(article);
    saveBookmarks();
  }

  void removeBookmark(NewsModel article) {
    bookmarks.remove(article);
    saveBookmarks();
  }

  bool isBookmarked(NewsModel article) {
    return bookmarks.any((a) => a.link == article.link);
  }

  void saveBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> stringList = bookmarks
        .map((e) => json.encode({
              'title': e.title,
              'description': e.description,
              'link': e.link,
              'pubDate': e.pubDate,
              'source_id': e.source_id,
              'image_url': e.image_url,
            }))
        .toList();
    prefs.setStringList('bookmarks', stringList);
  }

  void loadBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? stringList = prefs.getStringList('bookmarks');
    if (stringList != null) {
      bookmarks.assignAll(stringList.map((e) {
        var data = json.decode(e);
        return NewsModel.fromJson(data);
      }).toList());
    }
  }
}
