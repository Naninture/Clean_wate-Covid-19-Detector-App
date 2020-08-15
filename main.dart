import 'package:clean_water_detector/pages/Home.dart';
import 'package:clean_water_detector/pages/instructions.dart';
import 'package:clean_water_detector/pages/loading.dart';
import 'package:clean_water_detector/pages/x_ray.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData.dark(), initialRoute: '/', routes: {
      '/': (context) => Loading(),
      '/intro': (context) => Intro(),
      '/home': (context) => Home(),
      '/x_ray': (context) => X_ray(),

      // '/webView': (context) => (),
    });
  }
}
