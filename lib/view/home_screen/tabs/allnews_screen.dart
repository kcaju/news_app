import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/controller/allnews_controller.dart';
import 'package:news_app/view/news_detailscreen/news_details_screen.dart';
import 'package:provider/provider.dart';

class AllnewsScreen extends StatefulWidget {
  const AllnewsScreen({super.key});

  @override
  State<AllnewsScreen> createState() => _AllnewsScreenState();
}

class _AllnewsScreenState extends State<AllnewsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context.read<AllnewsController>().getEverything();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final allProv = context.watch<AllnewsController>();
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          allProv.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    String date = DateFormat('dd/MM/yy -kk:mm').format(
                        allProv.allObj?.articles?[index].publishedAt ??
                            DateTime.now());

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsDetailsScreen(
                                index: index,
                                tabCategoryOption: 1,
                                allObj: allProv.allObj,
                              ),
                            ));
                      },
                      child: Card(
                        child: ListTile(
                            title: Text(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              allProv.allObj?.articles?[index].title ?? "",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  allProv.allObj?.articles?[index].content ??
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
                                      image: CachedNetworkImageProvider(allProv
                                              .allObj
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
                  itemCount: allProv.allObj?.articles?.length ?? 0)
        ],
      ),
    );
  }
}
