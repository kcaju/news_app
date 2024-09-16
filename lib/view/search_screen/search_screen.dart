import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/controller/searchscreen_controller.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextFormField(
              onChanged: (value) async {
                if (value.length.isEven) {
                  await context
                      .read<SearchscreenController>()
                      .searchData(value);
                } else {
                  SizedBox();
                }
              },
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.grey),
                  suffix: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: Consumer<SearchscreenController>(
              builder: (context, value, child) => ListView.builder(
                itemCount: value.searchObj?.articles?.length ?? 0,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  String formattedDate = DateFormat('dd/MM/yy -kk:mm').format(
                      value.searchObj?.articles?[index].publishedAt ??
                          DateTime.now());
                  return value.isLoad
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Card(
                          child: ListTile(
                              title: Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                value.searchObj?.articles?[index].title ?? "",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    value.searchObj?.articles?[index].content ??
                                        "",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                  Text(
                                    formattedDate,
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
                                        image: CachedNetworkImageProvider(value
                                                .searchObj
                                                ?.articles?[index]
                                                .urlToImage ??
                                            ""))),
                              )),
                        );
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}
