import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:memorize_wodrds/src/components/toast_dialog.dart';
import 'package:memorize_wodrds/src/network/firebase_manager.dart';
import 'package:memorize_wodrds/src/static/strings_data.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  // Firebase Instance
  final FirebaseManager firebaseManager = FirebaseManager();

  late TextEditingController _wordController; // = TextEditingController();
  late TextEditingController _meaningController; // = TextEditingController();

  @override
  void initState() {
    super.initState();
    _wordController = TextEditingController();
    _meaningController = TextEditingController();
  }

  @override
  void dispose() {
    _wordController.dispose();
    _meaningController.dispose();
    super.dispose();
  }

  void wordSaveData(String word, String meaning) {
    Map<String, dynamic> data;

    if (word.isNotEmpty && meaning.isNotEmpty) {
      data = {word: meaning};
      firebaseManager.addWord(data);

      _wordController.clear();
      _meaningController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.STR_ADD_SCREEN_WORD_ADD),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              autofocus: true,
              controller: _wordController,
              decoration: InputDecoration(
                labelText: Strings.STR_COMMON_WODRD,
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: IconButton(
                    onPressed: () {
                      _wordController.clear();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _meaningController,
              decoration: InputDecoration(
                labelText: Strings.STR_COMMON_MEANING,
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: IconButton(
                    onPressed: () {
                      _meaningController.clear();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_wordController.text.isEmpty) {
                  ToastDialog.showToastDialog(
                      context, Strings.STR_ADD_SCREEN_WORD_NOT_AVAILABLE);
                } else if (_meaningController.text.isEmpty) {
                  ToastDialog.showToastDialog(
                      context, Strings.STR_ADD_SCREEN_MEANING_NOT_AVAILABLE);
                } else {
                  ToastDialog.showToastDialog(
                      context, Strings.STR_ADD_SCREEN_WORD_SAVE_SUCCESS);
                  wordSaveData(_wordController.text, _meaningController.text);
                }
              },
              child: const Text(Strings.STR_COMMON_ADD),
            ),
          ],
        ),
      ),
    );
  }
}
