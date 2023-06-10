import 'package:flutter/material.dart';
import 'package:memorize_wodrds/src/components/toast_dialog.dart';

import '../network/firebase_manager.dart';
import '../static/common_data.dart';
import '../static/strings_data.dart';

class EditDialog extends StatefulWidget {
  final String editText;
  final String meaningText;
  final int editType;
  final String okButtonText;
  final String cancelButtonText;

  const EditDialog({
    Key? key,
    required this.editText,
    required this.meaningText,
    required this.editType,
    required this.okButtonText,
    required this.cancelButtonText,
  }) : super(key: key);

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  late TextEditingController _wordController;
  late TextEditingController _meaningController;

  final FirebaseManager firebaseManager = FirebaseManager();

  @override
  void initState() {
    super.initState();
    _wordController = TextEditingController(text: widget.editText);
    _meaningController = TextEditingController(text: widget.meaningText);
  }

  void editData(String word, String meaning) {
    if (word.isNotEmpty && meaning.isNotEmpty) {
      if (widget.editType == Common.wordType) {
        firebaseManager.editWordMeaning(word, meaning);
      } else {
        firebaseManager.editSentenceMeaning(word, meaning);
      }

      _wordController.clear();
      _meaningController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 300,
                child: TextField(
                  autofocus: false,
                  enabled: false,
                  controller: _wordController,
                  decoration: InputDecoration(
                    labelText: Strings.STR_COMMON_WORD,
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
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 300,
                child: TextField(
                  autofocus: true,
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
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size(100, 40),
                        ),
                        onPressed: () async {
                          editData(_wordController.text, _meaningController.text);
                          Navigator.pop(context);
                        },
                        child: Text(widget.okButtonText),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          minimumSize: const Size(100, 40),
                        ),
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: Text(widget.cancelButtonText),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showEditDialog(
    BuildContext context, String edit, String meaning, int editType) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return EditDialog(
        editText: edit,
        meaningText: meaning,
        editType: editType,
        okButtonText: Strings.STR_COMMON_OK,
        cancelButtonText: Strings.STR_COMMON_CANCEL,
      );
    },
  );
}
