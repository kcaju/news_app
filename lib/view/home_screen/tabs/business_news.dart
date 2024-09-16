import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/controller/businessnews_controller.dart';
import 'package:news_app/view/news_detailscreen/news_details_screen.dart';
import 'package:provider/provider.dart';

class BusinessNews extends StatefulWidget {
  const BusinessNews({super.key});

  @override
  State<BusinessNews> createState() => _BusinessNewsState();
}

class _BusinessNewsState extends State<BusinessNews> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<BusinessnewsController>().getBusinessNews();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BusinessnewsController>(
      builder: (context, businessProv, child) => SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            businessProv.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      String date = DateFormat('dd/MM/yy -kk:mm').format(
                          businessProv
                                  .businessObj?.articles?[index].publishedAt ??
                              DateTime.now());

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsDetailsScreen(
                                  tabCategoryOption: 5,
                                  index: index,
                                  businessObj: businessProv.businessObj,
                                ),
                              ));
                        },
                        child: Card(
                          child: ListTile(
                              title: Text(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                businessProv
                                        .businessObj?.articles?[index].title ??
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
                                    businessProv.businessObj?.articles?[index]
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
                                            businessProv
                                                    .businessObj
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
                    itemCount: businessProv.businessObj?.articles?.length ?? 0)
          ],
        ),
      ),
    );
  }
}
