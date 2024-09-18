import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/utils/color_constants.dart';

class NewsCard extends StatelessWidget {
  const NewsCard(
      {super.key,
      required this.title,
      required this.content,
      required this.image,
      this.removeBookmark,
      this.readMore});
  final String title;
  final String content;
  final String image;
  final VoidCallback? removeBookmark;
  final VoidCallback? readMore;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: ColorConstants.blue,
              image: DecorationImage(
                  fit: BoxFit.fill, image: CachedNetworkImageProvider(image))),
        ),
        title: Expanded(
          child: Text(title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: ColorConstants.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: ColorConstants.black, fontSize: 16)),
            TextButton(
                onPressed: readMore,
                child: Text(
                  "...Read more",
                  style: TextStyle(fontSize: 16, color: ColorConstants.blue),
                ))
          ],
        ),
        trailing: InkWell(
          onTap: removeBookmark,
          child: CircleAvatar(
            backgroundColor: ColorConstants.black,
            child: Icon(
              Icons.bookmark_remove,
              color: ColorConstants.red,
            ),
          ),
        ),
      ),
    );
  }
}
