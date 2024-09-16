import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/model/home_screen/news_res_model.dart';

class HomescreenController with ChangeNotifier {
  NewsResModel? newsObj;
  bool isLoading = false;
  Future<void> fetchTopHeadlines() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=667a9bfdfb8f47eb8f17b02a7028f1d7");
    var responseData = await http.get(url);
    print(responseData.statusCode);
    // print(responseData.body);
    if (responseData.statusCode == 200) {
      newsObj = newsResModelFromJson(responseData.body);
      isLoading = false;
    }
    notifyListeners();
  }
}
