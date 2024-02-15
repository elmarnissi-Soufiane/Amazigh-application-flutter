import 'package:flutter/material.dart';
import 'package:tefenaghe_ap/screens/detection_screen.dart';
import 'package:tefenaghe_ap/screens/account_screen.dart';
import 'package:tefenaghe_ap/screens/home_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'dart:io';

class CoursesScreens extends StatefulWidget {
  List<String> courseNames = [
    "initiation",
    "Intermediate",
    "kabyle",
    "المعجم الامازيغي",
    "vocabulaire_grammatical",
    "amawal-ar_amz_fr",
    "amawal_tjerrumt",
    "معجميةالادارةامازيغي"
  ];

  List<String> courseDescriptions = [
    "Initiation to the Amazigh language",
    "Study program for beginner and intermediate students",
    "Alphabet kabyle à l'usage des orthophonistes",
    "المعجم الامازيغي الوظيفي...يغي - د الارضي مبارك",
    "vocabulaire_grammatical",
    "Amawal Arabe amazigh Français",
    "Amawal Tjerrmut",
    "معجميةالادارةامازيغي"
  ];

  @override
  State<CoursesScreens> createState() => _CoursesScreensState();
}

class _CoursesScreensState extends State<CoursesScreens> {
  int _currentIndex = 0;

  void _navigateToDetectionScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetectionScreen()),
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

  /*void downloadCourse(String courseName) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String courseDirPath = '${appDocDir.path}/courses';
    String courseFilePath = '$courseDirPath/$courseName.pdf';

    if (!await Directory(courseDirPath).exists()) {
      await Directory(courseDirPath).create(recursive: true);
    }

    if (!await File(courseFilePath).exists()) {
      String sourceFilePath = 'courses/$courseName.pdf';

      try {
        final taskId = await FlutterDownloader.enqueue(
          url: sourceFilePath,
          savedDir: courseDirPath,
          fileName: '$courseName.pdf',
          showNotification: true,
          openFileFromNotification: true,
        );

        FlutterDownloader.registerCallback((id, status, progress) {
          if (status == DownloadTaskStatus.complete && id == taskId) {
            print('Course download completed: $courseName');
            // Handle completion logic here
          }
        });

        print('Course download started: $courseName');
      } catch (error) {
        print('Error while starting the download: $error');
        // Handle download errors here
      }
    } else {
      print('Course already downloaded: $courseName');
    }
  }*/

  /*void downloadCourse(String courseName) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String courseDirPath = '${appDocDir.path}/courses';
    String courseFilePath = '$courseDirPath/$courseName.pdf';

    if (!await Directory(courseDirPath).exists()) {
      await Directory(courseDirPath).create(recursive: true);
    }

    if (!await File(courseFilePath).exists()) {
      String sourceFilePath = 'courses/$courseName.pdf';

      try {
        final taskId = await FlutterDownloader.enqueue(
          url: sourceFilePath,
          savedDir: courseDirPath,
          fileName: '$courseName.pdf',
          showNotification: true,
          openFileFromNotification: true,
        );

        FlutterDownloader.registerCallback((id, status, progress) {
          if (status == DownloadTaskStatus.complete && id == taskId) {
            print('Course download completed: $courseName');
            // Handle completion logic here
          }
        });

        print('Course download started: $courseName');
      } catch (error) {
        print('Error while starting the download: $error');
        // Handle download errors here
      }
    } else {
      print('Course already downloaded: $courseName');
    }
  }*/

  void downloadCourse(String courseName) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String courseDirPath = '${appDocDir.path}/courses';
    String courseFilePath = '$courseDirPath/$courseName.pdf';

    if (!await Directory(courseDirPath).exists()) {
      await Directory(courseDirPath).create(recursive: true);
    }

    if (!await File(courseFilePath).exists()) {
      String sourceFileUrl =
          'http://localhost/courses/$courseName.pdf'; // Replace with the actual URL of the PDF file

      try {
        final taskId = await FlutterDownloader.enqueue(
          url: sourceFileUrl,
          savedDir: courseDirPath,
          fileName: '$courseName.pdf',
          showNotification: true,
          openFileFromNotification: true,
        );

        FlutterDownloader.registerCallback((id, status, progress) {
          if (status == DownloadTaskStatus.complete && id == taskId) {
            print('Course download completed: $courseName');
            // Handle completion logic here
          }
        });

        print('Course download started: $courseName');
      } catch (error) {
        print('Error while starting the download: $error');
        // Handle download errors here
      }
    } else {
      print('Course already downloaded: $courseName');
    }
  }

  Widget _buildCourseItem(String courseName, String courseDescription) {
    return ListTile(
      title: Text(courseName),
      subtitle: Text(courseDescription),
      trailing: ElevatedButton(
        onPressed: () {
          downloadCourse(courseName);
        },
        child: Text('Download'),
      ),
    );
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
          "Courses",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [],
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
            _navigateToHomePage(context);
          } else if (index == 1) {
            // Handle "Détection" tab click event
            _navigateToDetectionScreen(context);
          } else if (index == 2) {
            // Handle "Courses" tab click event
            // Already on the Courses screen, no need to navigate
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
      body: ListView.builder(
        itemCount: widget.courseNames.length,
        itemBuilder: (context, index) {
          final courseName = widget.courseNames[index];
          final courseDescription = widget.courseDescriptions[index];
          return _buildCourseItem(courseName, courseDescription);
        },
      ),
    );
  }
}
