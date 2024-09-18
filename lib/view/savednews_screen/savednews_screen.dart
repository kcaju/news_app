import 'package:flutter/material.dart';
import 'package:news_app/controller/savednews_controller.dart';
import 'package:news_app/utils/color_constants.dart';
import 'package:news_app/view/savednews_screen/widget/news_card.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SavednewsScreen extends StatefulWidget {
  const SavednewsScreen({super.key});

  @override
  State<SavednewsScreen> createState() => _SavednewsScreenState();
}

class _SavednewsScreenState extends State<SavednewsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<SavednewsController>().getAllSavedNews();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      appBar: AppBar(
        backgroundColor: ColorConstants.black,
        centerTitle: true,
        title: Text(
          "Saved News",
          style: TextStyle(
              color: ColorConstants.white,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<SavednewsController>(
        builder: (context, savedProv, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      final savedNews =
                          savedProv.getCurrentNews(savedProv.keys[index]);
                      return NewsCard(
                        title: savedNews?.title ?? "",
                        content: savedNews?.content ?? "",
                        image: savedNews?.image ?? "",
                        removeBookmark: () {
                          context
                              .read<SavednewsController>()
                              .removeSavedNews(savedProv.keys[index]);
                        },
                        readMore: () async {
                          final Uri url = Uri.parse(savedNews?.url ?? "");
                          if (!await launchUrl(url,
                              mode: LaunchMode.platformDefault)) {
                            throw Exception('Could not launch $url');
                          }
                        },
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                    itemCount: savedProv.keys.length),
              )
            ],
          );
        },
      ),
    );
  }
}
