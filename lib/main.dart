import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/controller/allnews_controller.dart';
import 'package:news_app/controller/businessnews_controller.dart';
import 'package:news_app/controller/healthnews_controller.dart';
import 'package:news_app/controller/homescreen_controller.dart';
import 'package:news_app/controller/movienews_controller.dart';
import 'package:news_app/controller/savednews_controller.dart';
import 'package:news_app/controller/searchscreen_controller.dart';
import 'package:news_app/controller/sportsnews_controller.dart';
import 'package:news_app/model/savednews_screen/savednews_model.dart';
import 'package:news_app/view/getstart_screen/getstart_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<SavednewsModel>(SavednewsModelAdapter());
  var box = await Hive.openBox<SavednewsModel>("newsBox");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomescreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => AllnewsController(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchscreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => BusinessnewsController(),
        ),
        ChangeNotifierProvider(
          create: (context) => HealthnewsController(),
        ),
        ChangeNotifierProvider(
          create: (context) => SportsnewsController(),
        ),
        ChangeNotifierProvider(
          create: (context) => MovienewsController(),
        ),
        ChangeNotifierProvider(
          create: (context) => SavednewsController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: GetstartScreen(),
      ),
    );
  }
}
