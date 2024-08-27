import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class WordQuiz extends StatefulWidget {
  @override
  _WordQuizState createState() => _WordQuizState();
}

class _WordQuizState extends State<WordQuiz> {
  late Map<int, Map<String, String>> kelimeler;
  late int currentID;
  late String currentKey;
  late String currentValue;
  bool isShowingValue = false;
  String previousKey = '';
  String previousValue = '';
  Random random = Random();

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
          value: (item) => {'kelime': item['kelime'], 'ceviri': item['ceviri']}
      );
      selectRandomKey();
    });
  }

  void selectRandomKey() {
    currentID = kelimeler.keys.elementAt(random.nextInt(kelimeler.length));
    currentKey = kelimeler[currentID]!['kelime']!;
    currentValue = kelimeler[currentID]!['ceviri']!;
    previousKey = currentKey;
    previousValue = currentValue;
  }

  void gosterValue() {
    setState(() {
      isShowingValue = !isShowingValue;
    });
  }

  void ileriGit() {
    setState(() {
      previousKey = currentKey;
      previousValue = currentValue;
      // Geçerli anahtarın dışında rastgele bir anahtar seçiyoruz.
      int newID;
      do {
        newID = kelimeler.keys.elementAt(random.nextInt(kelimeler.length));
      } while (newID == currentID);

      currentID = newID;
      currentKey = kelimeler[newID]!['kelime']!;
      currentValue = kelimeler[newID]!['ceviri']!;
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
              onTap: gosterValue,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: geriGit,
                  child: Text('Geri'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: ileriGit,
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
