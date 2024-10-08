import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/controller/savednews_controller.dart';
import 'package:news_app/model/home_screen/news_res_model.dart';
import 'package:news_app/model/tabs_model/allnews_model.dart';
import 'package:news_app/model/tabs_model/businessnews_model.dart';
import 'package:news_app/model/tabs_model/healthnews_model.dart';
import 'package:news_app/model/tabs_model/moviesnews_model.dart';
import 'package:news_app/model/tabs_model/sportsnews_model.dart';
import 'package:news_app/utils/color_constants.dart';
import 'package:provider/provider.dart';

class NewsDetailsScreen extends StatefulWidget {
  const NewsDetailsScreen(
      {super.key,
      required this.index,
      required this.tabCategoryOption,
      this.allObj,
      this.sportsObj,
      this.healthObj,
      this.movieObj,
      this.businessObj,
      this.newsObj,
      this.readMore});
  final VoidCallback? readMore;
  final int index,
      tabCategoryOption; // The category of the news tab and index of article in the list
  final EveryNewsResModel? allObj;
  final SportsResModel? sportsObj;
  final HealthResModel? healthObj;
  final MoviesResModel? movieObj;
  final BusinessResModel? businessObj;
  final NewsResModel? newsObj;

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  bool isSaved = false;
  @override
  void initState() {
    // Check if the article is saved when the widget is initialized
    _checkIfSaved();
    super.initState();
  }

  // Retrieve the current article based on the category option
  dynamic _getArticle() {
    switch (widget.tabCategoryOption) {
      case 1:
        return widget.allObj?.articles?[widget.index];
      case 2:
        return widget.sportsObj?.articles?[widget.index];
      case 3:
        return widget.healthObj?.articles?[widget.index];
      case 4:
        return widget.movieObj?.articles?[widget.index];
      case 5:
        return widget.businessObj?.articles?[widget.index];
      case 6:
        return widget.newsObj?.articles?[widget.index];
      default:
        return widget.allObj?.articles?[widget.index];
    }
  }

  Future<void> _checkIfSaved() async {
    final saveProv = context.read<SavednewsController>();
    final article = _getArticle();
    final keys = saveProv.keys;
    for (var key in keys) {
      final savedArticle = saveProv.getCurrentNews(key);
      if (savedArticle?.title == article.title) {
        setState(() {
          isSaved = true;
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the article details
    final article = _getArticle();

    String date = DateFormat('dd/MM/yy - kk:mm')
        .format(article.publishedAt ?? DateTime.now());
    //provider object
    final saveProv = context.watch<SavednewsController>();

    return Scaffold(
      backgroundColor: ColorConstants.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 380,
                ),
                Container(
                  padding: EdgeInsets.only(right: 30, top: 30),
                  height: 350,
                  alignment: Alignment.topRight,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: CachedNetworkImageProvider(
                        article.urlToImage ?? "",
                      ),
                    ),
                    color: ColorConstants.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Positioned(
                  right: 20,
                  bottom: 0,
                  child: InkWell(
                    // Bookmark button to save or unsave the article
                    onTap: () {
                      setState(() {
                        isSaved = !isSaved;
                        if (isSaved) {
                          context.read<SavednewsController>().saveNews(
                              title: article.title ?? "",
                              url: article.url ?? "",
                              date: date,
                              content: article.content ?? "",
                              image: article.urlToImage ?? "");
                        } else {
                          final keys = saveProv.keys;
                          for (var key in keys) {
                            final savedArticle = saveProv.getCurrentNews(key);
                            if (savedArticle?.title == article.title) {
                              context
                                  .read<SavednewsController>()
                                  .removeSavedNews(key);
                              break;
                            }
                          }
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: ColorConstants.white),
                      child: Icon(
                        isSaved
                            ? Icons.bookmark_add
                            : Icons.bookmark_add_outlined,
                        size: 50,
                        color: ColorConstants.deepblue,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title ?? "",
                    style: TextStyle(color: ColorConstants.white, fontSize: 25),
                  ),
                  SizedBox(height: 15),
                  Text(
                    date,
                    style: TextStyle(color: ColorConstants.white, fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    article.description ?? "",
                    style: TextStyle(color: ColorConstants.white, fontSize: 20),
                  ),
                  Text(
                    article.content ?? "",
                    style: TextStyle(color: ColorConstants.white, fontSize: 20),
                  ),
                  TextButton(
                    onPressed: widget.readMore,
                    child: Text(
                      ".......Read more",
                      style:
                          TextStyle(color: ColorConstants.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
