import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/controller/savednews_controller.dart';
import 'package:news_app/utils/color_constants.dart';
import 'package:provider/provider.dart';

class SearchednewsDetailscreen extends StatefulWidget {
  const SearchednewsDetailscreen(
      {super.key,
      required this.title,
      required this.image,
      required this.content,
      required this.date,
      this.readMore});
  final String title, image, content, date;
  final VoidCallback? readMore;

  @override
  State<SearchednewsDetailscreen> createState() =>
      _SearchednewsDetailscreenState();
}

class _SearchednewsDetailscreenState extends State<SearchednewsDetailscreen> {
  bool isSaved = false;
  @override
  void initState() {
    _checkIfSaved();
    super.initState();
  }

  Future<void> _checkIfSaved() async {
    final savedNewsController = context.read<SavednewsController>();
    // Check if the news item is already saved
    final keys = savedNewsController.keys;
    for (var key in keys) {
      final item = savedNewsController.getCurrentNews(key);
      if (item?.title == widget.title) {
        setState(() {
          isSaved = true;
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        widget.image,
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
                              title: widget.title,
                              date: widget.date,
                              content: widget.content,
                              image: widget.image);
                        } else {
                          final keys = saveProv.keys;
                          for (var key in keys) {
                            final savedArticle = saveProv.getCurrentNews(key);
                            if (savedArticle?.title == widget.title) {
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
                      child: isSaved
                          ? Icon(
                              Icons.bookmark_add,
                              size: 50,
                              color: ColorConstants.deepblue,
                            )
                          : Icon(
                              Icons.bookmark_add_outlined,
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
                    widget.title,
                    style: TextStyle(color: ColorConstants.white, fontSize: 25),
                  ),
                  SizedBox(height: 15),
                  Text(
                    widget.date,
                    style: TextStyle(color: ColorConstants.white, fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  // Text(
                  //   article.description ?? "",
                  //   style: TextStyle(color: ColorConstants.white, fontSize: 20),
                  // ),
                  Text(
                    widget.content,
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
