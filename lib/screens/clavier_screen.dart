import 'package:flutter/material.dart';
import 'package:tefenaghe_ap/screens/detection_screen.dart';
import 'package:tefenaghe_ap/screens/account_screen.dart';
import 'package:tefenaghe_ap/screens/courses_screens.dart';
import 'package:tefenaghe_ap/screens/home_screen.dart';

class ClavierScreen extends StatefulWidget {
  @override
  State<ClavierScreen> createState() => _ClavierScreenState();
}

class _ClavierScreenState extends State<ClavierScreen> {
  int _currentIndex = 0;
  TextEditingController _textEditingController = TextEditingController();

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
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _appendText(String text) {
    setState(() {
      _textEditingController.text += text;
    });
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
          "Clavier",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _textEditingController,
              readOnly: true, // Disable the default keyboard
              decoration: InputDecoration(
                labelText: '',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: GridView.extent(
              maxCrossAxisExtent: 150,
              padding: EdgeInsets.all(8.0),
              children: [
                buildKey(
                  'Supprimer',
                  '',
                  Icons.backspace,
                  gradientColors: [Color(0xFF0084FF), Color(0xFFFBBC05)],
                ),
                for (int i = 0; i < amazighCharacters.length; i++)
                  buildKey(
                    amazighCharacters[i],
                    amazighCharacterNames[i],
                    null,
                  ),
                buildKey(
                  'Espace',
                  '',
                  Icons.space_bar,
                  gradientColors: [Color(0xFF0084FF), Color(0xFFFBBC05)],
                ),
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
            _navigateToHomePage(context);
          } else if (index == 1) {
            // Handle "Détection" tab click event
            _navigateToDetectionScreen(context);
          } else if (index == 2) {
            // Handle "Courses" tab click event
            _navigateToCoursesScreens(context);
          } else if (index == 3) {
            // Handle "Account" tab click event
            _navigateToAccountScreen(context);
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Détection',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }

  Widget buildKey(String keyText, String keyName, IconData? icon,
      {List<Color>? gradientColors}) {
    return GestureDetector(
      onTap: () {
        if (keyText == 'Espace') {
          _appendText(' ');
        } else if (keyText == 'Supprimer') {
          _removeLastCharacter();
        } else {
          _appendText(keyText);
        }
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          gradient: LinearGradient(
            colors: gradientColors ?? [Colors.blue, Colors.green],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[400]!,
              offset: Offset(0, 2),
              blurRadius: 4.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(
                icon,
                size: 24.0,
                color: Colors.white,
              ),
            SizedBox(height: 4.0),
            Text(
              keyText,
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white), // Adjust the font size as needed
            ),
            SizedBox(height: 4.0),
            Text(
              keyName,
              style: TextStyle(fontSize: 8.0, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  void _removeLastCharacter() {
    setState(() {
      String currentText = _textEditingController.text;
      if (currentText.isNotEmpty) {
        _textEditingController.text =
            currentText.substring(0, currentText.length - 1);
      }
    });
  }
}

void main() {
  runApp(MaterialApp(
    home: ClavierScreen(),
  ));
}

List<String> amazighCharacters = [
  "ⴰ",
  "ⴱ",
  "ⵛ",
  "ⴷ",
  "ⴹ",
  "ⵄ",
  "ⴼ",
  "ⴳ",
  "ⵖ",
  "ⴳⵯ",
  "ⵀ",
  "ⵃ",
  "ⵊ",
  "ⴽ",
  "ⴽⵯ",
  "ⵍ",
  "ⵎ",
  "ⵏ",
  "ⵇ",
  "ⵔ",
  "ⵕ",
  "ⵙ",
  "ⵚ",
  "ⵜ",
  "ⵟ",
  "ⵡ",
  "ⵅ",
  "ⵢ",
  "ⵣ",
  "ⵥ",
  "ⴻ",
  "ⵉ",
  "ⵓ",
];

List<String> amazighCharacterNames = [
  'ya',
  'yab',
  'yach',
  'yad',
  'yadd',
  'yae',
  'yaf',
  'yag',
  'yagh',
  'yagw',
  'yah',
  'yahh',
  'yaj',
  'yak',
  'yakw',
  'yal',
  'yam',
  'yan',
  'yaq',
  'yar',
  'yarr',
  'yas',
  'yass',
  'yat',
  'yatt',
  'yaw',
  'yax',
  'yay',
  'yaz',
  'yazz',
  'yey',
  'yi',
  'yu',
];
