import 'package:flutter/material.dart';
import 'package:memorize_wodrds/src/components/app_bar_widget.dart';
import 'package:memorize_wodrds/src/components/left_menu.dart';
import 'package:memorize_wodrds/src/components/search_bar_widget.dart';
import 'package:memorize_wodrds/src/network/firebase_manager.dart';
import 'package:memorize_wodrds/src/screen/detail_screen.dart';
import 'package:memorize_wodrds/src/static/strings_data.dart';

import '../static/common_data.dart';

class SentenceSearchScreen extends StatefulWidget {
  const SentenceSearchScreen({Key? key}) : super(key: key);

  @override
  _SentenceSearchScreenState createState() => _SentenceSearchScreenState();
}

class _SentenceSearchScreenState extends State<SentenceSearchScreen> {
  final FirebaseManager firebaseManager = FirebaseManager();
  final _controller = TextEditingController();
  List<String> _searchResults = [];
  Map<String, String> _meanings = {};

  void _handleSearch(String query) {
    firebaseManager.searchSentences(query).then((results) {
      firebaseManager.getMeanings(results, Strings.STR_FIRESTORE_SENTENCES_FILED).then((meanings) {
        setState(() {
          _searchResults = results;
          _meanings = meanings ?? {};
        });
      });
    });
  }

  void _showDetailScreen(String sentence, String meaning) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(text: sentence, meaning: meaning, type: Common.sentenceType),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const LeftMenu(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: SearchBarWidget(
                onSearch: _handleSearch,
                controller: _controller,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (BuildContext context, int index) {
                    final result = _searchResults[index];
                    final meaning = _meanings[result];

                    final query = _controller.text.toLowerCase();

                    final startIndex = result.toLowerCase().indexOf(query);
                    final endIndex = startIndex + query.length;

                    if (startIndex == -1) {
                      return ListTile(
                        title: Text(result),
                      );
                    }

                    return ListTile(
                      title: RichText(
                        text: TextSpan(
                          text: result.substring(0, startIndex),
                          style: const TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: result.substring(startIndex, endIndex),
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 23,
                              ),
                            ),
                            TextSpan(
                              text: result.substring(endIndex),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      subtitle: Text(_meanings[result] ?? ''),
                      onTap: () {
                        final selectedSentence = _searchResults[index];
                        final selectedMeaning = _meanings[selectedSentence];
                        _showDetailScreen(selectedSentence.toString(),
                            selectedMeaning.toString());
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
