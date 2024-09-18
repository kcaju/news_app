import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/controller/homescreen_controller.dart';
import 'package:news_app/utils/color_constants.dart';
import 'package:news_app/view/home_screen/tabs/allnews_screen.dart';
import 'package:news_app/view/home_screen/tabs/business_news.dart';
import 'package:news_app/view/home_screen/tabs/healthnews_screen.dart';
import 'package:news_app/view/home_screen/tabs/movienews_screen.dart';
import 'package:news_app/view/home_screen/tabs/sportsnews_screen.dart';
import 'package:news_app/view/news_detailscreen/news_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context.read<HomescreenController>().fetchTopHeadlines();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeProv = context.watch<HomescreenController>();
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          backgroundColor: ColorConstants.black,
          appBar: AppBar(
            backgroundColor: ColorConstants.black,
            leading: Icon(
              Icons.menu,
              color: ColorConstants.white,
            ),
            centerTitle: true,
            title: Text(
              "News-App",
              style: TextStyle(
                  color: ColorConstants.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  "Top Headlines",
                  style: TextStyle(
                      color: ColorConstants.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              CarouselSlider(
                  items: List.generate(
                    homeProv.newsObj?.articles?.length ?? 0,
                    (index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsDetailsScreen(
                                  index: index,
                                  tabCategoryOption: 6,
                                  newsObj: homeProv.newsObj,
                                  readMore: () async {
                                    final Uri url = Uri.parse(homeProv
                                            .newsObj?.articles?[index].url ??
                                        "");
                                    if (!await launchUrl(url,
                                        mode: LaunchMode.platformDefault)) {
                                      throw Exception('Could not launch $url');
                                    }
                                  },
                                ),
                              ));
                        },
                        child: _buildCard(
                            homeProv.newsObj?.articles?[index].title ?? "",
                            homeProv.newsObj?.articles?[index].urlToImage ?? "",
                            homeProv.newsObj?.articles?[index].publishedAt ??
                                DateTime.now(),
                            homeProv.newsObj?.articles?[index].author ?? ""),
                      );
                    },
                  ),
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    height: 280,
                    viewportFraction: 1.0,
                  )),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 10),
              //     child: Row(
              //       children: List.generate(
              //         homeProv.newsObj?.articlesList?.length ?? 0,
              //         (index) => Row(
              //           children: [
              //             _buildCard(
              //                 homeProv.newsObj?.articlesList?[index].title ??
              //                     "",
              //                 homeProv.newsObj?.articlesList?[index]
              //                         .urlToImage ??
              //                     "",
              //                 homeProv.newsObj?.articlesList?[index]
              //                         .publishedAt ??
              //                     DateTime.now(),
              //                 homeProv.newsObj?.articlesList?[index].author ??
              //                     ""),
              //             SizedBox(
              //               width: 15,
              //             )
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 15,
              ),
              TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  labelColor: ColorConstants.white,
                  unselectedLabelColor: ColorConstants.grey,
                  labelStyle: TextStyle(fontSize: 12),
                  tabs: [
                    Tab(
                      text: "All",
                    ),
                    Tab(
                      text: "Business",
                    ),
                    Tab(
                      text: "Health",
                    ),
                    Tab(
                      text: "Sports",
                    ),
                    Tab(
                      text: "Movies",
                    ),
                  ]),
              Expanded(
                  child: TabBarView(children: [
                AllnewsScreen(),
                BusinessNews(),
                HealthnewsScreen(),
                SportsnewsScreen(),
                MovienewsScreen(),
              ]))
              // homeProv.isLoading == false
              //     ? Expanded(
              //         child: ListView.separated(
              //             scrollDirection: Axis.horizontal,
              //             itemBuilder: (context, index) => Container(
              //                   child: Column(
              //                     children: [
              //                       Text(
              //                         homeProv.newsObj?.articlesList?[index]
              //                                 .author ??
              //                             "",
              //                         style: TextStyle(color: Colors.white),
              //                       )
              //                     ],
              //                   ),
              //                 ),
              //             separatorBuilder: (context, index) => SizedBox(
              //                   height: 15,
              //                 ),
              //             itemCount: homeProv.newsObj?.articlesList?.length ?? 0),
              //       )
              //     : Center(child: CircularProgressIndicator()),
            ],
          )),
    );
  }

  ClipRRect _buildCard(String title, String img, DateTime date, String author) {
    String formattedDate = DateFormat('dd/MM/yy -kk:mm').format(date);
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
          height: 280,
          width: 350,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          decoration: BoxDecoration(
            color: ColorConstants.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(img))),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: ColorConstants.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                formattedDate,
                style: TextStyle(
                    color: ColorConstants.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                author,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: ColorConstants.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              )
            ],
          )),
    );
  }
}
