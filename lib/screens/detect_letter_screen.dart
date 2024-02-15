import 'package:flutter/material.dart';
import 'package:tefenaghe_ap/screens/detection_screen.dart';
import 'package:tefenaghe_ap/screens/account_screen.dart';
import 'package:tefenaghe_ap/screens/courses_screens.dart';
import 'package:tefenaghe_ap/screens/home_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:tflite/tflite.dart';

class DetectLetterScreen extends StatefulWidget {
  @override
  State<DetectLetterScreen> createState() => _DetectLetterScreenState();
}

class _DetectLetterScreenState extends State<DetectLetterScreen> {
  int _currentIndex = 0;
  File? _image;
  late List<dynamic> _results;
  bool _imageSelected = false;

  void _navigateToDetectionScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetectionScreen()),
    );
  }

  void _navigateToCoursesScreens(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CoursesScreens()),
    );
  }

  void _navigateToAccountScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AccountScreen()),
    );
  }

  void _navigateToHomePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    Tflite.close();
    String res;
    res = (await Tflite.loadModel(
      model: "models/model_pick.tflite",
      labels: "models/sorted-33-common-tifinagh.txt",
    ))!;
    print("Models loading status: $res");
  }

  Future<void> _getImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      _performImageClassification();
    }
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      _performImageClassification();
    }
  }

  Future<void> _performImageClassification() async {
    if (_image != null) {
      final recognitions = await Tflite.runModelOnImage(
        path: _image!.path,
        numResults: 6,
        threshold: 0.05,
        imageMean: 127.5,
        imageStd: 127.5,
      );
      setState(() {
        _results = recognitions!;
        _imageSelected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Detect Letter",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_imageSelected && _image != null)
            Center(
              child: Column(
                children: [
                  Image.file(
                    _image!,
                    height: 200,
                    width: 200,
                  ),
                  SizedBox(height: 10),
                  if (_results.isNotEmpty)
                    Column(
                      children: _results.map((result) {
                        return Card(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              "${result['label']} - ${result['confidence'].toStringAsFixed(2)}",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                ],
              ),
            )
          else
            Container(
              margin: EdgeInsets.all(10),
              child: Opacity(
                opacity: 0.8,
                child: Center(
                  child: Text("No Image"),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _getImageFromGallery();
          _getImageFromCamera();
        },
        tooltip: "Pick Image",
        child: const Icon(Icons.image),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        iconSize: 32,
        selectedItemColor: Color(0xFF674EFE),
        selectedFontSize: 18,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            _navigateToHomePage(context);
          } else if (index == 1) {
            _navigateToDetectionScreen(context);
          } else if (index == 2) {
            _navigateToCoursesScreens(context);
          } else if (index == 3) {
            _navigateToAccountScreen(context);
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt), label: 'Détection'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), label: 'Courses'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}
