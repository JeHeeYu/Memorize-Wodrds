import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:memorize_wodrds/src/components/app_bar_widget.dart';
import 'package:memorize_wodrds/src/components/left_menu.dart';
import 'package:memorize_wodrds/src/static/strings_data.dart';

class WordScreen extends StatefulWidget {
  final String word;
  final String meaning;

  const WordScreen({Key? key, required this.word, required this.meaning})
      : super(key: key);

  @override
  _WordScreenState createState() => _WordScreenState();
}

class _WordScreenState extends State<WordScreen> {
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    flutterTts.setLanguage("en-US");
  }

  Future<void> _speak() async {
    await flutterTts.speak(widget.word);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: Strings.STR_COMMON_WODRD,
      ),
      drawer: const LeftMenu(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.word,
              style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              widget.meaning,
              style: const TextStyle(fontSize: 28),
            ),
            const SizedBox(height: 20),
            IconButton(
              iconSize: 30,
              onPressed: _speak,
              icon: const Icon(Icons.volume_mute),
              tooltip: 'Listen to pronunciation',
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}