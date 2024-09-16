import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/model/search_screen/searchscreen_model.dart';

class SearchscreenController with ChangeNotifier {
  SearchNewsResModel? searchObj;
  bool isLoad = false;
  Future<void> searchData(String query) async {
    isLoad = true;
    notifyListeners();
    final url = Uri.parse(
        "https://newsapi.org/v2/everything?q=$query&apiKey=667a9bfdfb8f47eb8f17b02a7028f1d7");
    var searchdata = await http.get(url);
    print(searchdata.statusCode);
    if (searchdata.statusCode == 200) {
      searchObj = searchNewsResModelFromJson(searchdata.body);
      isLoad = false;
    }
    notifyListeners();
  }
}
