import 'package:clean_water_detector/pages/instructions.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  // Future transition() async{
  //   Navigator.pushReplacementNamed(context, '/home');
  //   return await Future.delayed(Duration(seconds: 4));
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   transition();
  // }
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 4,
        navigateAfterSeconds: Intro(),
        // Home()
        // title: new Text('Welcome In SplashScreen'),
        // image: new Image.asset('screenshot.png'),
        imageBackground: AssetImage('assets/loadingnew.gif'),
        // backgroundColor: Colors.white,
        loadingText: Text(
          "Loading...",
          style: TextStyle(
              color: Color(0xFF08d9d6), fontFamily: 'Lobster', fontSize: 28.0),
        ),
        // styleTextUnderTheLoader: new TextStyle(color: Color(0xFF08d9d6)),
        // photoSize: 100.0,
        loaderColor: Color.alphaBlend(Color(0xFF14ffec), Color(0xFF00e0ff)));
    // Navigator.pushReplacementNamed(context, '/home');
  }
}
