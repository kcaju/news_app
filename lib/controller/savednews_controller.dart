import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:news_app/model/savednews_screen/savednews_model.dart';

class SavednewsController with ChangeNotifier {
  final newsBox = Hive.box<SavednewsModel>("newsBox");
  List keys = [];
  Future<void> saveNews(
      {required String title,
      required String date,
      String? image,
      String? url,
      String? content}) async {
    bool alreadySaved = false;
    for (int i = 0; i < keys.length; i++) {
      //checking whether the id of added item is in hive(use get fnct)
      var iteminHive = newsBox.get(keys[i]);
      if (iteminHive?.title == title) {
        alreadySaved = true;
      }
    }
    if (alreadySaved == false) {
      await newsBox.add(SavednewsModel(
          url: url, title: title, content: content, date: date, image: image));
      keys = newsBox.keys.toList();
    } else {
      print("error");
    }
    notifyListeners();
  }

  removeSavedNews(var key) async {
    await newsBox.delete(key);
    keys = newsBox.keys.toList();
    notifyListeners();
  }

  getAllSavedNews() {
    keys = newsBox.keys.toList();
    notifyListeners();
  }

//for getting the current item
  SavednewsModel? getCurrentNews(var key) {
    final currentNews = newsBox.get(key);
    return currentNews;
  }
}
