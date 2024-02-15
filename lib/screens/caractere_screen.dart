import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class CaractereScreen extends StatefulWidget {
  final String character;
  final String characterClass;
  final String characterPhonetique;

  CaractereScreen({
    required this.character,
    required this.characterClass,
    required this.characterPhonetique,
  });

  @override
  State<CaractereScreen> createState() => _CaractereScreenState();
}

class _CaractereScreenState extends State<CaractereScreen> {
  late AudioPlayer audioPlayer;
  late String audioPath;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioPath = '';
    audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        isPlaying = false;
      });
    });
    loadAudio();
  }

  void loadAudio() async {
    final appDir = await getTemporaryDirectory();
    final uniqueFileName =
        '${widget.characterClass}_${DateTime.now().millisecondsSinceEpoch}.mp3';
    final filePath = '${appDir.path}/$uniqueFileName';
    final file = File(filePath);
    final ByteData data =
        await rootBundle.load('audios/${widget.characterClass}.mp3');
    await file.writeAsBytes(data.buffer.asUint8List());
    setState(() {
      audioPath = filePath;
    });
  }

  void playPauseAudio() async {
    if (isPlaying) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.play(audioPath, isLocal: true);
    }

    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  void dispose() {
    audioPlayer.release();
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
          "Tfinaghe",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ListView(
          children: [
            Container(
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(55),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.yellow, Colors.green, Colors.blue],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Text(
                    widget.character,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                color: Color(0xFFF5F3FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    widget.characterClass,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.characterPhonetique,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Material(
                        color: Color(0xFF674EFE),
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: playPauseAudio,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 35,
                            ),
                            child: Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
