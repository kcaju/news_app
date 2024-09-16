import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/model/tabs_model/allnews_model.dart';

class AllnewsController with ChangeNotifier {
  EveryNewsResModel? allObj;
  bool isLoading = false;
  Future<void> getEverything() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse(
        "https://newsapi.org/v2/everything?q=keyword&apiKey=667a9bfdfb8f47eb8f17b02a7028f1d7");
    var allNews = await http.get(url);
    print(allNews.statusCode);
    if (allNews.statusCode == 200) {
      allObj = everyNewsResModelFromJson(allNews.body);
      isLoading = false;
    }
    notifyListeners();
  }
}
