import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

  // final GoogleSignIn _googleSignIn =
  //     GoogleSignIn(scopes: ['email'], signInOption: SignInOption.standard);

  Widget hello() {
    if (_output[0]['Label'] == 'Dirty Water' &&
        _output[0]['confidence'] >= 70) {
      Row(
        children: [
          Text(
            "${_output[0]["label"]}",
            style: TextStyle(fontSize: 14.0),
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            '\n${_output[0]["confidence"] * 100}%',
            style: TextStyle(
                color: Colors.redAccent,
                fontSize: 28,
                fontWeight: FontWeight.bold),
          )
        ],
      );
    } else {
      Text(
        "${_output[0]["label"]}\n\n${_output[0]["confidence"] * 100}%",
        style: TextStyle(fontSize: 14.0),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: CupertinoIcons.home, title: 'Home'),
          TabItem(icon: Icons.local_hospital, title: 'X_ray'),
        ],
        initialActiveIndex: 0, //optional, default as 0
        onTap: (index) {
          _currentIndex = index;
          if (_currentIndex == 1) {
            // setState(() {
            Navigator.pushReplacementNamed(
                context,
                // PageTransition(
                //     curve: Curves.easeInOut,
                //     type: PageTransitionType.upToDown,
                //     duration: Duration(milliseconds: 200),
                //     inheritTheme: true,
                //     ctx: context,
                '/x_ray');
            // _currentIndex = 0;
            // });
          }
        },
      ),
      appBar: AppBar(
        title: GradientText("Clean Water Detector",
            gradient: LinearGradient(colors: [
              Color(0xFFbbe1fa),
              Color(0xFF3282b8),
              Color(0xFFbbe1fa)
            ]),
            style: TextStyle(fontSize: 26),
            textAlign: TextAlign.center),
        centerTitle: true,
        actions: [
          // ClipOval(
          //     child: FlatButton(
          //   onPressed: () {},
          //   child: Image.network(_googleSignIn.currentUser.photoUrl),
          // ))
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
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
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
        model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }
}
