import 'package:flutter/material.dart';
import 'package:tefenaghe_ap/screens/detection_screen.dart';
import 'package:tefenaghe_ap/screens/account_screen.dart';
import 'package:tefenaghe_ap/screens/courses_screens.dart';
import 'package:tefenaghe_ap/screens/home_screen.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

class SpeechTextScreen extends StatefulWidget {
  @override
  State<SpeechTextScreen> createState() => _SpeechTextScreenState();
}

class _SpeechTextScreenState extends State<SpeechTextScreen> {
  int _currentIndex = 0;

  TextEditingController _textEditingController = TextEditingController();
  String _audioContent = '';
  AudioPlayer _audioPlayer = AudioPlayer();

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

  Future<void> _convertBase64ToAudio(String base64Audio) async {
    Uint8List audioBytes = base64Decode(base64Audio);

    String tempFilePath = await _saveTempAudioFile(audioBytes);

    //await _audioPlayer.stop(); // Stop any ongoing playback
    await _audioPlayer.play(tempFilePath, isLocal: true);
  }

  Future<String> _saveTempAudioFile(Uint8List audioBytes) async {
    String tempDir = (await getTemporaryDirectory()).path;
    String tempFilePath = '$tempDir/audio_temp.wav';

    File tempFile = File(tempFilePath);
    await tempFile.writeAsBytes(audioBytes);

    return tempFilePath;
  }

  /*Future<void> _sendTextToServer(String text) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.150:5000/api/tts'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'text': text}),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      setState(() {
        _audioContent = responseData['content'];
      });
      _convertBase64ToAudio(_audioContent);
    } else {
      print('Failed to send text to server.');
    }
  }*/

  Future<void> _sendTextToServer(String text) async {
    int maxRetries = 3;
    int retryCount = 0;

    while (retryCount < maxRetries) {
      try {
        final response = await http.post(
          Uri.parse('http://127.0.0.1:5000/api/tts'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'text': text}),
        );

        if (response.statusCode == 200) {
          Map<String, dynamic> responseData = jsonDecode(response.body);
          setState(() {
            _audioContent = responseData['content'];
          });
          _convertBase64ToAudio(_audioContent);
          return; // Success, exit the loop
        } else {
          print(
              'Failed to send text to server. Status code: ${response.statusCode}');
          retryCount++;
        }
      } catch (e) {
        print('Error: $e');
        retryCount++;
      }
    }

    print('Reached maximum retry count. Giving up.');
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          /*foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('Speech to text'),
        actions: [],*/
          ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(labelText: 'Enter Text'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String text = _textEditingController.text;
                _sendTextToServer(text);
              },
              child: Text('Convert to Speech'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (_audioPlayer.state == PlayerState.PLAYING) {
                      await _audioPlayer.pause();
                    } else {
                      await _audioPlayer.resume();
                    }
                    setState(() {});
                  },
                  child: Icon(
                    _audioPlayer.state == PlayerState.PLAYING
                        ? Icons.pause
                        : Icons.play_arrow,
                    size: 40,
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
          ],
        ),
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
