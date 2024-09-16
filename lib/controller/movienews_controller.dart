import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/model/tabs_model/moviesnews_model.dart';

class MovienewsController with ChangeNotifier {
  MoviesResModel? movieObj;
  bool isLoading = false;
  Future<void> getMovieNews() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse(
        "https://newsapi.org/v2/everything?q=movies&apiKey=667a9bfdfb8f47eb8f17b02a7028f1d7");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      movieObj = moviesResModelFromJson(response.body);
      isLoading = false;
    }
    notifyListeners();
  }
}
