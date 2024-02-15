import 'package:flutter/material.dart';
import 'package:tefenaghe_ap/screens/course_screen.dart';
import 'package:tefenaghe_ap/screens/letter_screen.dart';
import 'package:tefenaghe_ap/screens/clavier_screen.dart';
import 'package:tefenaghe_ap/screens/traduction_screen.dart';
import 'package:tefenaghe_ap/screens/detection_screen.dart';
import 'package:tefenaghe_ap/screens/account_screen.dart';
import 'package:tefenaghe_ap/screens/courses_screens.dart';
import 'package:tefenaghe_ap/screens/speech_text_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  List<String> catNames = [
    "Lettre",
    "Clavier",
    "Traduction",
    "Détection",
    "Free Course",
    "Speech to text"
  ];

  List<Color> catColors = [
    Color(0xFF19db69),
    Color(0xFFd3a115),
    Color(0xFF83adb5),
    Color(0xFFf07219),
    Color(0xFF00ced1),
    Color(0xFF244236),
  ];

  List<Icon> catIcons = [
    Icon(Icons.text_fields, color: Colors.white, size: 30),
    Icon(Icons.keyboard, color: Colors.white, size: 30),
    Icon(Icons.translate, color: Colors.white, size: 30),
    Icon(Icons.camera, color: Colors.white, size: 30),
    Icon(Icons.book, color: Colors.white, size: 30),
    Icon(Icons.audiotrack, color: Colors.white, size: 30),
  ];

  List<String> imgList = ["Kabyle", "Beginning", "Textbook", "Acknowledgement"];

  void _navigateToLetterScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LetterScreen()),
    );
  }

  void _navigateToTraductionScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TraductionScreen()),
    );
  }

  void _navigateToSpeechTextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SpeechTextScreen()),
    );
  }

  void _navigateToDetectionScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetectionScreen()),
    );
  }

  void _navigateToClavierScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ClavierScreen()),
    );
  }

  void _navigateToAccountScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AccountScreen()),
    );
  }

  /*void _navigateToCourseScreen(BuildContext context, String img) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CourseScreen(img)),
    );
  }*/

  void _navigateToCoursesScreens(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CoursesScreens()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 15, right: 15, left: 15, bottom: 15),
            decoration: BoxDecoration(
              color: Color(0xFF674EFE),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.dashboard,
                      size: 30,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.notifications,
                      size: 30,
                      color: Colors.white,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(left: 3, bottom: 15),
                  child: Text(
                    "Hi, Friends from tifinaghe",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      wordSpacing: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search here........",
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.5)),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Column(
              children: [
                GridView.builder(
                  itemCount: catNames.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            if (index == 0) {
                              _navigateToLetterScreen(context);
                            } else if (index == 1) {
                              _navigateToClavierScreen(context);
                            } else if (index == 2) {
                              _navigateToTraductionScreen(context);
                            } else if (index == 3) {
                              _navigateToDetectionScreen(context);
                            } else if (index == 4) {
                              _navigateToCoursesScreens(context);
                            } else if (index == 5) {
                              _navigateToSpeechTextScreen(context);
                            }
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: catColors[index],
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: catIcons[index],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          catNames[index],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        )
                      ],
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Courses",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "See all",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF674EFE),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                GridView.builder(
                  itemCount: imgList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio:
                        (MediaQuery.of(context).size.height - 50 - 50) /
                            (4 * 240),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        //_navigateToCourseScreen(context, imgList[index]);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CourseScreen(imgList[index]),
                          ),
                        );
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255, 219, 218, 221),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Image.asset(
                                "images/${imgList[index]}.png", // For PNG images
                                // OR
                                //"images/${imgList[index]}.jpg", // For JPG images
                                width: 100,
                                height: 100,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              imgList[index],
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
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
            // Handle "Home" tab click event
            // You can add your own logic here
          } else if (index == 1) {
            // Handle "Détection" tab click event
            _navigateToDetectionScreen(context);
          } else if (index == 2) {
            // Handle "Courses" tab click event
            // You can add your own logic here
            _navigateToCoursesScreens(context);
            //_navigateToCourseScreen(context, imgList[2]);
          } else if (index == 3) {
            // Handle "Account" tab click event
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

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
