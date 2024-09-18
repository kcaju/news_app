import 'package:flutter/material.dart';
import 'package:news_app/utils/color_constants.dart';
import 'package:news_app/view/bottomnav_screen/bottomnav_screen.dart';

class GetstartScreen extends StatelessWidget {
  const GetstartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: 200,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Come on, get the latetst and updates Articles Easily with us everyday !!",
              style: TextStyle(color: ColorConstants.white, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(ColorConstants.blue)),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BottomnavScreen(),
                      ));
                },
                child: Text(
                  "GO >>",
                  style: TextStyle(color: ColorConstants.white, fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}
