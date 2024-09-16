import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/model/home_screen/news_res_model.dart';
import 'package:news_app/model/tabs_model/allnews_model.dart';
import 'package:news_app/model/tabs_model/businessnews_model.dart';
import 'package:news_app/model/tabs_model/healthnews_model.dart';
import 'package:news_app/model/tabs_model/moviesnews_model.dart';
import 'package:news_app/model/tabs_model/sportsnews_model.dart';
import 'package:news_app/utils/color_constants.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen(
      {super.key,
      required this.index,
      required this.tabCategoryOption,
      this.allObj,
      this.sportsObj,
      this.healthObj,
      this.movieObj,
      this.businessObj,
      this.newsObj});

  final int index, tabCategoryOption;
  final EveryNewsResModel? allObj;
  final SportsResModel? sportsObj;
  final HealthResModel? healthObj;
  final MoviesResModel? movieObj;
  final BusinessResModel? businessObj;
  final NewsResModel? newsObj;

  @override
  Widget build(BuildContext context) {
    // Declare a variable to hold the correct data model instance
    dynamic dataObj;

    // Assign dataObj based on tabCategoryOption
    switch (tabCategoryOption) {
      case 1:
        dataObj = allObj;
        break;
      case 2:
        dataObj = sportsObj;
        break;
      case 3:
        dataObj = healthObj;
        break;
      case 4:
        dataObj = movieObj;
        break;
      case 5:
        dataObj = businessObj;
        break;
      case 6:
        dataObj = newsObj;
        break;
      default:
        dataObj =
            allObj; // Default case, you might want to handle this differently
    }

    // Use the dataObj to access the article details
    final article = dataObj?.articles?[index];
    // if (article == null) {
    //   return Scaffold(
    //     backgroundColor: ColorConstants.black,
    //     body: Center(
    //       child: Text(
    //         'Article not found',
    //         style: TextStyle(color: ColorConstants.white, fontSize: 20),
    //       ),
    //     ),
    //   );
    // }

    String date = DateFormat('dd/MM/yy - kk:mm')
        .format(article.publishedAt ?? DateTime.now());

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
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: ColorConstants.white),
                    child: Icon(
                      Icons.bookmark_add,
                      size: 50,
                      color: ColorConstants.deepblue,
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
                    onPressed: () {},
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
