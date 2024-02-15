import 'package:flutter/material.dart';
import 'package:tefenaghe_ap/screens/detection_screen.dart';
import 'package:tefenaghe_ap/screens/account_screen.dart';
import 'package:tefenaghe_ap/screens/courses_screens.dart';
import 'package:tefenaghe_ap/screens/home_screen.dart';
//import 'package:tefenaghe_ap/screens/detail_traduction_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class TraductionScreen extends StatefulWidget {
  @override
  _TraductionScreenState createState() => _TraductionScreenState();
}

class _TraductionScreenState extends State<TraductionScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> results = [];
  Timer? _typingTimeout;

  /*void handleSearch(String term) async {
    try {
      final response = await http.get(Uri.parse(
          'https://tal.ircam.ma/dglai/service/ssourceauto.php?term=$term'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        setState(() {
          results = data.sublist(0, 60);
        });
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }*/

  void handleSearch(String term) async {
    try {
      final response = await http.get(Uri.parse(
          'https://tal.ircam.ma/dglai/service/ssourceauto.php?term=$term'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)
            as List<Map<String, dynamic>>; // Specify the type
        setState(() {
          results = data.sublist(0, 60);
        });
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  void handleTyping(String term) {
    if (_typingTimeout != null && _typingTimeout!.isActive) {
      _typingTimeout!.cancel();
    }

    _typingTimeout = Timer(const Duration(milliseconds: 1200), () {
      handleSearch(term);
    });
  }

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
    _searchController.addListener(() {
      handleTyping(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _typingTimeout?.cancel();
    super.dispose();
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
          "Traduction",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [],
      ),
      body: Column(
        children: [
          // Search
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey, size: 20),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              hintText: 'ⴰⴱⵛⴷ [abcd]...',
                            ),
                            onChanged: (value) {
                              handleTyping(value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Icon(Icons.settings, color: Color(0xFF00CCBB)),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: results.map((result) {
                return MotCard(
                  id: result['id'],
                  value: result['value'],
                  lexie: result['lexie'],
                );
              }).toList(),
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
        onTap: (index) {
          if (index == 0) {
            // Handle "Home" tab click event
            // You can add your own logic here
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
              icon: Icon(Icons.camera_alt), label: 'Détection'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), label: 'Courses'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}

/*class MotCard extends StatelessWidget {
  final int id;
  final String value;
  final String lexie;

  MotCard({required this.id, required this.value, required this.lexie});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('ID: $id'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Value: $value'),
            Text('Lexie: $lexie'),
          ],
        ),
      ),
    );
  }
}*/
/*class MotCard extends StatelessWidget {
  final int id;
  final String value;
  final String lexie;

  MotCard({required this.id, required this.value, required this.lexie});

  void _navigateToDetailedTraductionScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DetailedTraductionScreen(id: id.toString()), // Pass 'id' here
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('ID: $id'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Value: $value'),
            Text('Lexie: $lexie'),
          ],
        ),
        onTap: () {
          _navigateToDetailedTraductionScreen(context); // Navigate with 'id'
        },
      ),
    );
  }
}*/
class MotCard extends StatelessWidget {
  final int id;
  final String value;
  final String lexie;

  MotCard({required this.id, required this.value, required this.lexie});

  /*void _navigateToDetailedTraductionScreen(BuildContext context) {
    Navigator.push(
      context,
      /*MaterialPageRoute(
          //builder: (context) => DetailedTraductionScreen(id: id.toString()),
          ),*/
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('ID: $id'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Value: $value'),
            Text('Lexie: $lexie'),
          ],
        ),
        onTap: () {
          //_navigateToDetailedTraductionScreen(context);
        },
      ),
    );
  }
}
