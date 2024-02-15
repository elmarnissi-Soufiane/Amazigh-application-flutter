import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';
import 'dart:convert';

class DetailedTraductionScreen extends StatefulWidget {
  final String id;

  DetailedTraductionScreen({required this.id});

  @override
  _DetailedTraductionScreenState createState() =>
      _DetailedTraductionScreenState();
}

class _DetailedTraductionScreenState extends State<DetailedTraductionScreen> {
  List<dynamic> resultsClasses = [];
  Map<String, dynamic> resultsLexie = {};
  List<dynamic> resultsVariante = [];
  Map<String, dynamic> resultsDeclination = {};
  List<dynamic> resultsTraduction = [];
  Map<String, dynamic> resultsConjugaison = {};
  List<dynamic> resultsExpression = [];
  String audioUri = '';
  bool isLoading = true;
  String error = '';

  final API_URL_TTS = 'http://192.168.1.102:5000/api/tts';

  @override
  void initState() {
    super.initState();
    handleSearch(widget.id);
  }

  void transformText(inputText) {
    const mapping = {
      'ⴰ': 'a',
      'ⴱ': 'b',
      'ⵛ': 'c',
      'ⴷ': 'd',
      'ⴹ': 'ḍ',
      'ⵄ': 'ɛ',
      'ⴼ': 'f',
      'ⴳ': 'g',
      'ⵖ': 'ɣ',
      'ⵀ': 'h',
      'ⵃ': 'ḥ',
      'ⵊ': 'j',
      'ⴽ': 'k',
      'ⵍ': 'l',
      'ⵎ': 'm',
      'ⵏ': 'n',
      'ⵇ': 'q',
      'ⵔ': 'r',
      'ⵕ': 'ṛ',
      'ⵙ': 's',
      'ⵚ': 'ṣ',
      'ⵜ': 't',
      'ⵟ': 'ṭ',
      'ⵡ': 'w',
      'ⵅ': 'x',
      'ⵢ': 'y',
      'ⵣ': 'z',
      'ⵥ': 'ẓ',
      'ⴻ': 'e',
      'ⵉ': 'i',
      'ⵓ': 'u',
      'ⵯ': 'w',
    };

    final transformedText =
        inputText.split('').map((char) => mapping[char] ?? char).join('');
    return transformedText;
  }

  Future<void> handlePlayAudio() async {
    if (audioUri.isNotEmpty) {
      final ByteData data = await rootBundle.load(audioUri);
      final buffer = data.buffer.asUint8List();
      final player = AudioCache();
      await player.playBytes(buffer);
    }
  }

  Future<void> TTS() async {
    if (audioUri.isNotEmpty) {
      handlePlayAudio();
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(API_URL_TTS),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'text': transformText(resultsLexie['llexie'])}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final tmpFilename = 'assets/audio/speech.wav'; // Adjust this path
        audioUri = tmpFilename;
        handlePlayAudio();
      } else {
        throw Exception('Failed to load audio');
      }
    } catch (error) {
      print('Error sending text to API: $error');
    }
  }

  Future<void> handleSearch(String term) async {
    try {
      final resClasse = await http.get(Uri.parse(
          'https://tal.ircam.ma/dglai/service/classegs.php?lexie=$term'));
      final resLexie = await http.get(Uri.parse(
          'https://tal.ircam.ma/dglai/service/lexie.php?lexie=$term'));
      final resVariante = await http.get(Uri.parse(
          'https://tal.ircam.ma/dglai/service/variante.php?lexie=$term'));
      final resDeclination = await http.get(Uri.parse(
          'https://tal.ircam.ma/dglai/service/declinison.php?lexie=$term'));
      final resTraduction = await http.get(Uri.parse(
          'https://tal.ircam.ma/dglai/service/traduction.php?lexie=$term'));
      final resConjugaison = await http.get(Uri.parse(
          'https://tal.ircam.ma/dglai/service/conjugaison.php?lexie=$term'));
      final resExpression = await http.get(Uri.parse(
          'https://tal.ircam.ma/dglai/service/expression.php?lexie=$term'));

      setState(() {
        resultsClasses = json.decode(resClasse.body)['lexie'];
        resultsLexie = json.decode(resLexie.body)['lexie'][0];
        resultsVariante = json.decode(resVariante.body)['variantes'];
        resultsDeclination = json.decode(resDeclination.body)['declinison'][0];
        resultsTraduction = json.decode(resTraduction.body)['lexie'];
        resultsConjugaison = json.decode(resConjugaison.body)['conjugaison'][0];
        resultsExpression = json.decode(resExpression.body)['expression'];
        isLoading = false;
      });
    } catch (error) {
      print('Error fetching data: $error');
      setState(() {
        isLoading = false;
        this.error = error.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : error.isNotEmpty
              ? Center(child: Text(error))
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: TTS,
                          child: Row(
                            children: [
                              Text(resultsLexie['llexie'],
                                  style: TextStyle(fontSize: 16)),
                              Text(resultsLexie['lapi'],
                                  style: TextStyle(fontSize: 16)),
                              Text(
                                resultsVariante
                                    .map((result) => result['dvariante'])
                                    .join(', '),
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              resultsClasses
                                  .map((result) => result['classe'])
                                  .join(' et '),
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              resultsClasses
                                  .map((result) =>
                                      result['sclasse'].replaceAll(';', ' '))
                                  .join(''),
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        if (resultsConjugaison != null)
                          Row(
                            children: [
                              Text(
                                'Accompli : ${resultsConjugaison['laccompli']}',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Accompli négatif : ${resultsConjugaison['laccompli_neg']}',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Inaccompli : ${resultsConjugaison['linaccompli']}',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        if (resultsDeclination != null)
                          Text(
                            'Etat d\'annexion : ${resultsDeclination['lea']}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        if (resultsDeclination != null)
                          Text(
                            'Pluriel : ${resultsDeclination['lpl']}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        if (resultsTraduction.isNotEmpty)
                          Text(
                            'Sens',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        if (resultsTraduction.isNotEmpty)
                          Column(
                            children: resultsTraduction
                                .map(
                                  (result) => Column(
                                    children: [
                                      Text(
                                        result['fr']
                                            .substring(3)
                                            .replaceAll('9', "'"),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        result['ar'].substring(3),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        if (resultsExpression.isNotEmpty)
                          Column(
                            children: [
                              Text(
                                'Emploi',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              ...resultsExpression
                                  .map(
                                    (result) => Column(
                                      children: [
                                        Text(
                                          result['llib_exp'],
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          result['lexpfr'],
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          result['lexpar'],
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
