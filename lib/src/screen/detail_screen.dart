import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:memorize_wodrds/src/components/app_bar_widget.dart';
import 'package:memorize_wodrds/src/components/left_menu.dart';
import 'package:memorize_wodrds/src/static/strings_data.dart';

import '../components/edit_dialog.dart';
import '../components/select_dialog.dart';
import '../components/toast_dialog.dart';
import '../network/firebase_manager.dart';
import '../static/common_data.dart';
import '../static/images_data.dart';

class DetailScreen extends StatefulWidget {
  final String text;
  final String meaning;
  final int type;

  const DetailScreen(
      {Key? key, required this.text, required this.meaning, required this.type})
      : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final FlutterTts flutterTts = FlutterTts();
  int? _selectedOption;
  bool _isExpanded = false;

  final FirebaseManager firebaseManager = FirebaseManager();

  @override
  void initState() {
    super.initState();
    flutterTts.setLanguage("en-US");
  }

  Future<void> _speak() async {
    await flutterTts.speak(widget.text);
  }

  void _selectOption(int? selectIndex) {
    setState(() {
      _selectedOption = selectIndex;
      _isExpanded = false;
    });

    if (_selectedOption == 0) {
      showEditDialog(
          context, widget.text, widget.meaning, widget.type);
    } else if (_selectedOption == 1) {
      showSelectDialog(
          context, deletePopupSelection, Strings.STR_DELETE_QUESTION);
    }
  }

  void deletePopupSelection(int option) {
    if (option == 0) {
      if (widget.type == Common.wordType) {
        firebaseManager.deleteWord(widget.text);
        ToastDialog.showToastDialog(context, Strings.STR_WORD_DELETE_SUCCESS);
      } else {
        firebaseManager.deleteSentence(widget.text);
        ToastDialog.showToastDialog(context, Strings.STR_SENTENCE_DELETE_SUCCESS);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Spacer(),
                PopupMenuButton<int>(
                  icon: const Icon(Icons.more_horiz),
                  iconSize: 32,
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<int>>[
                      const PopupMenuItem<int>(
                        value: 0,
                        child: Text(Strings.STR_COMMON_EDIT),
                      ),
                      const PopupMenuItem<int>(
                        value: 1,
                        child: Text(Strings.STR_COMMON_DELETE),
                      ),
                    ];
                  },
                  onSelected: _selectOption,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 140,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.text,
                  style: const TextStyle(
                      fontSize: 34, fontWeight: FontWeight.bold),
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
        ],
      ),
    );
  }
}
