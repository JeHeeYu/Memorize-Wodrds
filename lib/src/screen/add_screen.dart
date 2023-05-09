import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
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
            const TextField(
              decoration: InputDecoration(
                labelText: Strings.STR_COMMON_WODRD,
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: Strings.STR_COMMON_MEANING,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                Map<String, dynamic> data = {
                  'Tissue': '휴지',
                  'Store': '상점',
                  'Smoke': '담배',
                  'Hello': '안녕',
                  'Sky': '하늘',
                  'Today': '오늘',
                };
                firebaseManager.addWord(data);

                bool apple = await firebaseManager.checkSavedWord('Apple');
                print("apple : ${apple}");
              },
              child: const Text(Strings.STR_COMMON_ADD),
            ),
          ],
        ),
      ),
    );
  }
}
