import 'dart:io';
import 'package:clean_water_detector/pages/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:page_transition/page_transition.dart';

class X_ray extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<X_ray> {
  bool _isLoading;
  File _image;
  List _output;

  @override
  void initState() {
    _isLoading = true;
    // TODO: implement initState
    super.initState();
    loadMLModel().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  var _currentIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: CupertinoIcons.home, title: 'Home'),
          TabItem(icon: Icons.local_hospital, title: 'X_ray'),
        ],
        initialActiveIndex: 1, //optional, default as 0
        onTap: (index) {
          _currentIndex = index;
          if (_currentIndex == 0) {
            // setState(() {
            Navigator.pushReplacementNamed(
                context,
                // PageTransition(
                //     type: PageTransitionType.downToUp,
                //     duration: Duration(milliseconds: 200),
                //     inheritTheme: true,
                //     ctx: context,
                '/home');
            // _currentIndex = 1;
            // });
          }
        },
      ),
      appBar: AppBar(
        title: GradientText("COVID-19 Detector",
            gradient: LinearGradient(colors: [
              Color(0xFFbbe1fa),
              Color(0xFF3282b8),
              Color(0xFFbbe1fa)
            ]),
            style: TextStyle(fontSize: 26),
            textAlign: TextAlign.center),
        centerTitle: true,
        actions: [
          Text(
            'beta',
            style: TextStyle(color: Colors.amber, fontSize: 18),
          )
        ],
      ),
      body: _isLoading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : DraggableScrollableSheet(
              maxChildSize: 1.0,
              initialChildSize: 1.0,
              minChildSize: 1.0,
              builder: (context, scrollController) => SingleChildScrollView(
                child: Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _image == null ? Container() : Image.file(_image),
                    SizedBox(height: 20.0),
                    _output == null
                        ? Text("")
                        : Text(
                            "${_output[0]["label"]}\n\n${_output[0]["confidence"] * 100}%",
                            style: TextStyle(fontSize: 14.0),
                          ),
                    SizedBox(
                      height: 20.0,
                    ),
                    // if (_output[0]["Label"] == "Dirty Water" &&
                    //     _output[0]["confidence"] >= 70)
                    //   {
                    //     Text(
                    //       "It seems your water is above the Danger Level, it will be better not to drink this water!!",
                    //       style: TextStyle(color: Colors.red, fontSize: 32.0),
                    //     )
                    //   }
                    // else
                    //   {}
                  ],
                )),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          chooseImage();
        },
        child: Icon(
          Icons.image,
        ),
      ),
    );
  }

  chooseImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 400,
        maxHeight: 300,
        imageQuality: 100);
    if (image == null) return null;
    setState(() {
      _isLoading = true;
      _image = image;
    });
    runModel(image);
  }

  runModel(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      imageMean: 127.5,
      imageStd: 127.5,
      threshold: 0.5,
      numResults: 2,
    );
    setState(() {
      _isLoading = false;
      _output = output;
    });
  }

  loadMLModel() async {
    await Tflite.loadModel(
        model: 'assets/model_unquant_X-Ray.tflite',
        labels: 'assets/labels-X-Ray.txt');
  }
}
