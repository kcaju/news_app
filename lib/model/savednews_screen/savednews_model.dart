import 'package:hive/hive.dart';
part 'savednews_model.g.dart';

@HiveType(typeId: 0)
class SavednewsModel {
  @HiveField(0)
  String title;
  @HiveField(1)
  String? content;
  @HiveField(2)
  String date;
  @HiveField(3)
  String? image;
  @HiveField(4)
  String? url;

  SavednewsModel(
      {required this.title,
      required this.content,
      this.image,
      this.url,
      required this.date});
}
