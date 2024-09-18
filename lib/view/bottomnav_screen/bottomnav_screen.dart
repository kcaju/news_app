import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:news_app/utils/color_constants.dart';
import 'package:news_app/view/home_screen/home_screen.dart';
import 'package:news_app/view/profile_screen/profile_screen.dart';
import 'package:news_app/view/savednews_screen/savednews_screen.dart';
import 'package:news_app/view/search_screen/search_screen.dart';

class BottomnavScreen extends StatefulWidget {
  const BottomnavScreen({super.key});

  @override
  State<BottomnavScreen> createState() => _BottomnavScreenState();
}

class _BottomnavScreenState extends State<BottomnavScreen> {
  List<Widget> bottomScreens = [
    HomeScreen(),
    SearchScreen(),
    SavednewsScreen(),
    ProfileScreen()
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bottomScreens[selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: ColorConstants.black,
          color: ColorConstants.blue,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          index: selectedIndex,
          items: [
            Icon(
              Icons.home,
              color: ColorConstants.white,
              size: 35,
            ),
            Icon(
              Icons.search,
              color: ColorConstants.white,
              size: 35,
            ),
            Icon(
              Icons.bookmark_add,
              color: ColorConstants.white,
              size: 35,
            ),
            Icon(
              Icons.people,
              color: ColorConstants.white,
              size: 35,
            ),
          ]),
    );
  }
}
