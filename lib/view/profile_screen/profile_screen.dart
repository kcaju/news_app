import 'package:flutter/material.dart';
import 'package:news_app/utils/color_constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: ColorConstants.black,
        centerTitle: true,
        title: Text("Profile",
            style: TextStyle(
                color: ColorConstants.white,
                fontSize: 25,
                fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.person,
              color: ColorConstants.white,
            ),
            title: Text("My Profile",
                style: TextStyle(
                    color: ColorConstants.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: ColorConstants.white,
            ),
            title: Text("Settings",
                style: TextStyle(
                    color: ColorConstants.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: Icon(
              Icons.notifications,
              color: ColorConstants.white,
            ),
            title: Text("Notifications",
                style: TextStyle(
                    color: ColorConstants.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: Icon(
              Icons.translate,
              color: ColorConstants.white,
            ),
            title: Text("Language",
                style: TextStyle(
                    color: ColorConstants.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: Icon(
              Icons.quiz,
              color: ColorConstants.white,
            ),
            title: Text("FAQ",
                style: TextStyle(
                    color: ColorConstants.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: Icon(
              Icons.error,
              color: ColorConstants.white,
            ),
            title: Text("About App",
                style: TextStyle(
                    color: ColorConstants.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
