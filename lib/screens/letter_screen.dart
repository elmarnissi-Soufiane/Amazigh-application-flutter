import 'package:flutter/material.dart';
import 'package:tefenaghe_ap/screens/detection_screen.dart';
import 'package:tefenaghe_ap/screens/account_screen.dart';
import 'package:tefenaghe_ap/screens/courses_screens.dart';
import 'package:tefenaghe_ap/screens/home_screen.dart';
import 'package:tefenaghe_ap/screens/caractere_screen.dart';

class LetterScreen extends StatefulWidget {
  @override
  State<LetterScreen> createState() => _LetterScreenState();
}

class _LetterScreenState extends State<LetterScreen> {
  int _currentIndex = 0;

  List<String> catLabels = [
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
    "ⵓ"
  ];

  List<String> class_names = [
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
    'yu'
  ];

  List<String> catLabelsPhonetique = [
    'Alif - a (comme dans "arbre" en français) - ألف (comme dans "أرض" en arabe)',
    'Ba - b (comme dans "bateau" en français) - باء (comme dans "بيت" en arabe)',
    'Cha - ch (comme dans "chat" en français) - شين (comme dans "شمس" en arabe)',
    'Daal - d (comme dans "danser" en français) - دال (comme dans "ضوء" en arabe)',
    'Daad - ḍ (comme dans "ḍar" en arabe) - ضاد (comme dans "ضحى" en arabe)',
    'Ayn - ɛ (comme dans "frère" en français) - عين (comme dans "عمر" en arabe)',
    'Faa - f (comme dans "fleur" en français) - فاء (comme dans "فاكهة" en arabe)',
    'Gaaf - g (comme dans "garçon" en français) - غين (comme dans "غابة" en arabe)',
    'Ghaaf - ɣ (comme dans "ghetto" en français) - غاف (comme dans "غزال" en arabe)',
    'Gaaf waaw - ɡʷ (comme dans "Gwenn" en français) - قاف واو (comme dans "قوس" en arabe)',
    'Haa - h (comme dans "heure" en français) - هاء (comme dans "حقيقة" en arabe)',
    'Ḥaa - ḥ (comme dans "ḥalal" en arabe) - حاء (comme dans "حلوى" en arabe)',
    'Jeem - j (comme dans "jour" en français) - جيم (comme dans "جمل" en arabe)',
    'Kaaf - k (comme dans "kilomètre" en français) - كاف (comme dans "كلب" en arabe)',
    'Kaaf waaw - kʷ (comme dans "kwassa-kwassa" en français) - قاف واو (comme dans "قوة" en arabe)',
    'Laam - l (comme dans "lune" en français) - لام (comme dans "ليلة" en arabe',
    'Miim - m (comme dans "maison" en français) - ميم (comme dans "ماء" en arabe)',
    'Nun - n (comme dans "nuit" en français) - نون (comme dans "نجمة" en arabe)',
    'Qaaf - q (comme dans "qamis" en français) - قاف (comme dans "قمر" en arabe)',
    'Raa - r (comme dans "rose" en français) - راء (comme dans "ربيع" en arabe)',
    'Raa alif - ṛ (comme dans "ṛif" en arabe) - راء ألف (comme dans "رفيق" en arabe)',
    'Siin - s (comme dans "soleil" en français) - سين (comme dans "سماء" en arabe)',
    'Siin soukoun - ṣ (comme dans "ṣaḥara" en arabe) - سين صلبة (comme dans "صحراء" en arabe)',
    'Tah - t (comme dans "table" en français) - تاء (comme dans "تفاحة" en arabe)',
    'Tah soukoun - ṭ (comme dans "ṭaṭwil" en arabe) - تاء صلبة (comme dans "طاولة" en arabe)',
    'Waaw - w (comme dans "week-end" en français) - واو (comme dans "وطن" en arabe)',
    'Khaf - kh (comme dans "khan" en arabe) - خاء (comme dans "خير" en arabe)',
    'Ya - y (comme dans "yaourt" en français) - ياء (comme dans "يد" en arabe',
    'Zaa - z (comme dans "zoo" en français) - زاي (comme dans "زهرة" en arabe)',
    'Zaa soukoun - ẓ (comme dans "ẓaliz" en arabe) - زاي صلبة (comme dans "صحراوي" en arabe)',
    'Ayn - e (comme dans "été" en français) - عين (comme dans "عيد" en arabe)',
    'Ya - i (comme dans "immeuble" en français) - ياء (comme dans "يوم" en arabe)',
    'Waw - ou (comme dans "ours" en français) - واو (comme dans "وقت" en arabe)'
  ];

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

  void _navigateToCaractereScreen(String selectedCharacter) {
    final selectedClass = class_names[catLabels.indexOf(selectedCharacter)];
    final selectedPhonetique =
        catLabelsPhonetique[catLabels.indexOf(selectedCharacter)];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CaractereScreen(
          character: selectedCharacter,
          characterClass: selectedClass,
          characterPhonetique: selectedPhonetique,
        ),
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
          "Letter",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: catLabels.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Number of columns
            crossAxisSpacing: 10, // Spacing between columns
            mainAxisSpacing: 10, // Spacing between rows
            childAspectRatio: 1, // Width to height ratio of each item
          ),
          itemBuilder: (context, index) {
            final selectedCharacter = catLabels[index];
            return GestureDetector(
              onTap: () {
                _navigateToCaractereScreen(selectedCharacter);
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.yellow, Colors.green, Colors.blue],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Text(
                    selectedCharacter,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36, // Adjust the icon size here
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        iconSize: 30,
        selectedItemColor: Color(0xFF674EFE),
        selectedFontSize: 16,
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
}
