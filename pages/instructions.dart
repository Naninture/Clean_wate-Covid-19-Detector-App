import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';

class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GradientText("How It Works",
            gradient: LinearGradient(colors: [
              Color(0xFF0f4c75),
              Color(0xFF3282b8),
              Color(0xFFbbe1fa)
            ]),
            style: TextStyle(fontSize: 36),
            textAlign: TextAlign.center),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color(0xFFf9f6f7),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/water-thing.gif'),
                fit: BoxFit.fitHeight)),
        // margin: EdgeInsets.all(8.0),
        // color: Color(0xFFf4f6ff),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Image.asset(
            //       'assets/e773e05aa0f3eaa727a14681a24e664d-1800w-1200h.jpg'),
            // ),
            SizedBox(
              height: 50.0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 200.0, 0.0, 0.0),
              child: Text(
                'Instuctions',
                style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6a197d)),
              ),
            ),
            SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 10.0, 5.0, 0.0),
              child: Text(
                'Use a clean transparent Glass and put water in that glass put the container on white surface (A white surface is preferable for better results) and take a photo and use it in our app for the Magic to happen',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0,
                    backgroundColor: Colors.blueGrey[400]),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 80.0),
            RaisedButton.icon(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              icon: Icon(Icons.navigate_next),
              label: Text('Next'),
              color: Color(0xFF848ccf),
            ),
          ],
        ),
      ),
    );
  }
}
