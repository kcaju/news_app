import 'package:flutter/material.dart';
import 'package:news_app/utils/color_constants.dart';

class SavednewsScreen extends StatefulWidget {
  const SavednewsScreen({super.key});

  @override
  State<SavednewsScreen> createState() => _SavednewsScreenState();
}

class _SavednewsScreenState extends State<SavednewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
    );
  }
}
