import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/controller/sportsnews_controller.dart';
import 'package:news_app/view/news_detailscreen/news_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SportsnewsScreen extends StatefulWidget {
  const SportsnewsScreen({super.key});

  @override
  State<SportsnewsScreen> createState() => _SportsnewsScreenState();
}

class _SportsnewsScreenState extends State<SportsnewsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<SportsnewsController>().getSportsNews();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SportsnewsController>(
      builder: (context, sportsProv, child) => SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            sportsProv.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      String date = DateFormat('dd/MM/yy -kk:mm').format(
                          sportsProv.sportsObj?.articles?[index].publishedAt ??
                              DateTime.now());

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsDetailsScreen(
                                  readMore: () async {
                                    final Uri url = Uri.parse(sportsProv
                                            .sportsObj?.articles?[index].url ??
                                        "");
                                    if (!await launchUrl(url,
                                        mode: LaunchMode.platformDefault)) {
                                      throw Exception('Could not launch $url');
                                    }
                                  },
                                  tabCategoryOption: 2,
                                  index: index,
                                  sportsObj: sportsProv.sportsObj,
                                ),
                              ));
                        },
                        child: Card(
                          child: ListTile(
                              title: Text(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                sportsProv.sportsObj?.articles?[index].title ??
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
                                    sportsProv.sportsObj?.articles?[index]
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
                                            sportsProv
                                                    .sportsObj
                                                    ?.articles?[index]
                                                    .urlToImage ??
                                                ""))),
                              )),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                    itemCount: sportsProv.sportsObj?.articles?.length ?? 0)
          ],
        ),
      ),
    );
  }
}
