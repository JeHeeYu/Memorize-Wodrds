import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:memorize_wodrds/src/components/app_bar_widget.dart';
import 'package:memorize_wodrds/src/components/left_menu.dart';
import 'package:memorize_wodrds/src/static/strings_data.dart';

class DetailScreen extends StatefulWidget {
  final String text;
  final String meaning;

  const DetailScreen({Key? key, required this.text, required this.meaning})
      : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    flutterTts.setLanguage("en-US");
  }

  Future<void> _speak() async {
    await flutterTts.speak(widget.text);
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
              widget.text,
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
