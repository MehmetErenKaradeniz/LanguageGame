import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;

class WordTest extends StatefulWidget {
  const WordTest({super.key});

  @override
  State<WordTest> createState() => _WordTestState();
}

class _WordTestState extends State<WordTest> {
  late Map<int, Map<String, String>> kelimeler;
  late int currentID;
  late String currentKey;
  late String currentValue;
  bool isShowingValue = false;
  String previousKey = '';
  String previousValue = '';
  Random random = Random();
  List<String> randomCevriler = [];
  String gelenDeger1 = '';
  String gelenDeger2 = '';
  String gelenDeger3 = '';
  Color cardColor1 = Colors.white;
  Color cardColor2 = Colors.white;
  Color cardColor3 = Colors.white;
  IconData icon1 = Icons.check;
  IconData icon2 = Icons.check;
  IconData icon3 = Icons.check;

  @override
  void initState() {
    super.initState();
    loadKelimeler();
  }

  Future<void> loadKelimeler() async {
    final String response = await rootBundle.loadString('assets/kelimeler.json');
    final data = json.decode(response);
    setState(() {
      kelimeler = Map.fromIterable(
        data['kelimeler'],
        key: (item) => item['id'],
        value: (item) => {'kelime': item['kelime'], 'ceviri': item['ceviri']},
      );
      selectRandomKey();
      selectRandomCevriler(); // Select random ceviri values
      gelenDegerler();
    });
  }

  void selectRandomKey() {
    currentID = kelimeler.keys.elementAt(random.nextInt(kelimeler.length));
    currentKey = kelimeler[currentID]!['kelime']!;
    currentValue = kelimeler[currentID]!['ceviri']!;
    previousKey = currentKey;
    previousValue = currentValue;
  }

  void selectRandomCevriler() {
    randomCevriler.clear();

    for (int i = 0; i < 3; i++) {
      int randomID = kelimeler.keys.elementAt(random.nextInt(kelimeler.length));
      randomCevriler.add(kelimeler[randomID]!['ceviri']!);
    }
  }

  void gelenDegerler() {
    List<String> values = [
      currentValue,
      randomCevriler.isNotEmpty ? randomCevriler[0] : '',
      randomCevriler.isNotEmpty ? randomCevriler[1] : '',
    ];
    values.shuffle();
    gelenDeger1 = values[0];
    gelenDeger2 = values[1];
    gelenDeger3 = values[2];
  }

  void checkAnswer(int index, String value) {
    setState(() {
      if (value == currentValue) {
        switch (index) {
          case 1:
            cardColor1 = Colors.green;
            icon1 = Icons.check_circle_outline;
            break;
          case 2:
            cardColor2 = Colors.green;
            icon2 = Icons.check_circle_outline;
            break;
          case 3:
            cardColor3 = Colors.green;
            icon3 = Icons.check_circle_outline;
            break;
        }
      } else {
        switch (index) {
          case 1:
            cardColor1 = Colors.red;
            icon1 = Icons.cancel_outlined;
            break;
          case 2:
            cardColor2 = Colors.red;
            icon2 = Icons.cancel_outlined;
            break;
          case 3:
            cardColor3 = Colors.red;
            icon3 = Icons.cancel_outlined;
            break;
        }
      }
    });
  }

  void geriGit() {
    setState(() {
      currentKey = previousKey;
      currentValue = previousValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kelime Oyunu'),
      ),
      body: kelimeler == null
          ? Center(child: CircularProgressIndicator())
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: 300,
                height: 100,
                color: Colors.grey[300],
                alignment: Alignment.center,
                child: Text(
                  isShowingValue ? currentValue : currentKey,
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                checkAnswer(1, gelenDeger1);
              },
              child: Card(
                color: cardColor1,
                child: ListTile(
                  title: Text(
                    gelenDeger1,
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(icon1),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                checkAnswer(2, gelenDeger2);
              },
              child: Card(
                color: cardColor2,
                child: ListTile(
                  title: Text(
                    gelenDeger2,
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(icon2),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                checkAnswer(3, gelenDeger3);
              },
              child: Card(
                color: cardColor3,
                child: ListTile(
                  title: Text(
                    gelenDeger3,
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(icon3),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: geriGit,
                  child: Text('Geri'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectRandomKey();
                      selectRandomCevriler();
                      gelenDegerler();
                      cardColor1 = Colors.white;
                      cardColor2 = Colors.white;
                      cardColor3 = Colors.white;
                      icon1 = Icons.check;
                      icon2 = Icons.check;
                      icon3 = Icons.check;
                    });
                  },
                  child: Text('İleri'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
