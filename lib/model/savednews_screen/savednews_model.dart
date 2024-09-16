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

  SavednewsModel(
      {required this.title,
      required this.content,
      this.image,
      required this.date});
}
