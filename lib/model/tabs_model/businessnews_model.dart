// To parse this JSON data, do
//
//     final businessResModel = businessResModelFromJson(jsonString);

import 'dart:convert';

BusinessResModel businessResModelFromJson(String str) =>
    BusinessResModel.fromJson(json.decode(str));

class BusinessResModel {
  String? status;
  int? totalResults;
  List<Article>? articles;

  BusinessResModel({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory BusinessResModel.fromJson(Map<String, dynamic> json) =>
      BusinessResModel(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: json["articles"] == null
            ? []
            : List<Article>.from(
                json["articles"]!.map((x) => Article.fromJson(x))),
      );
}

class Article {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  dynamic urlToImage;
  DateTime? publishedAt;
  String? content;

  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: json["source"] == null ? null : Source.fromJson(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: json["publishedAt"] == null
            ? null
            : DateTime.parse(json["publishedAt"]),
        content: json["content"],
      );
}

class Source {
  dynamic id;
  String? name;

  Source({
    this.id,
    this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"],
      );
}
