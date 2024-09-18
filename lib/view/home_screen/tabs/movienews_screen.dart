import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/controller/movienews_controller.dart';
import 'package:news_app/view/news_detailscreen/news_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MovienewsScreen extends StatefulWidget {
  const MovienewsScreen({super.key});

  @override
  State<MovienewsScreen> createState() => _MovienewsScreenState();
}

class _MovienewsScreenState extends State<MovienewsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<MovienewsController>().getMovieNews();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MovienewsController>(
      builder: (context, movieProv, child) => SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            movieProv.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      String date = DateFormat('dd/MM/yy -kk:mm').format(
                          movieProv.movieObj?.articles?[index].publishedAt ??
                              DateTime.now());

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsDetailsScreen(
                                  readMore: () async {
                                    final Uri url = Uri.parse(movieProv
                                            .movieObj?.articles?[index].url ??
                                        "");
                                    if (!await launchUrl(url,
                                        mode: LaunchMode.platformDefault)) {
                                      throw Exception('Could not launch $url');
                                    }
                                  },
                                  tabCategoryOption: 4,
                                  index: index,
                                  movieObj: movieProv.movieObj,
                                ),
                              ));
                        },
                        child: Card(
                          child: ListTile(
                              title: Text(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                movieProv.movieObj?.articles?[index].title ??
                                    "",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    movieProv.movieObj?.articles?[index]
                                            .content ??
                                        "",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                  Text(
                                    date,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                              trailing: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            movieProv.movieObj?.articles?[index]
                                                    .urlToImage ??
                                                ""))),
                              )),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                    itemCount: movieProv.movieObj?.articles?.length ?? 0)
          ],
        ),
      ),
    );
  }
}
