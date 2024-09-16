import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/controller/healthnews_controller.dart';
import 'package:news_app/view/news_detailscreen/news_details_screen.dart';
import 'package:provider/provider.dart';

class HealthnewsScreen extends StatefulWidget {
  const HealthnewsScreen({super.key});

  @override
  State<HealthnewsScreen> createState() => _HealthnewsScreenState();
}

class _HealthnewsScreenState extends State<HealthnewsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<HealthnewsController>().getHealthNews();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HealthnewsController>(
      builder: (context, healthProv, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              healthProv.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        String date = DateFormat('dd/MM/yy -kk:mm').format(
                            healthProv
                                    .healthObj?.articles?[index].publishedAt ??
                                DateTime.now());

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewsDetailsScreen(
                                    tabCategoryOption: 3,
                                    index: index,
                                    healthObj: healthProv.healthObj,
                                  ),
                                ));
                          },
                          child: Card(
                            child: ListTile(
                                title: Text(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  healthProv
                                          .healthObj?.articles?[index].title ??
                                      "",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      healthProv.healthObj?.articles?[index]
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
                                              healthProv
                                                      .healthObj
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
                      itemCount: healthProv.healthObj?.articles?.length ?? 0)
            ],
          ),
        );
      },
    );
  }
}
