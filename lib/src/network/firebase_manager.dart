import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

class FirebaseManager {
  late FirebaseFirestore _firestore;
  late CollectionReference _collectionName;
  late final String _collectionString;
  late final String _documentString;

  FirebaseManager() {
    _firestore = FirebaseFirestore.instance;
    _initialize();
  }

  Future<void> _initialize() async {
    _collectionString = await getCollectionName();
    _documentString = await getDocumentName();
    _collectionName = _firestore.collection(_collectionString);
  }

  Future<String> getCollectionName() async {
    final configStr = await rootBundle.loadString('assets/config.yaml');
    final config = loadYaml(configStr);
    return config['collectionName'] as String;
  }

  Future<String> getDocumentName() async {
    final configStr = await rootBundle.loadString('assets/config.yaml');
    final config = loadYaml(configStr);
    return config['documentName'] as String;
  }

  Future<void> addWord(Map<String, dynamic> data) async {
    try {
      await _collectionName
          .doc(_documentString)
          .set(data, SetOptions(merge: true));
      print('Data added');
    } catch (e) {
      print('Failed to add data: $e');
    }
  }

  Future<String?> readMeaning(String key) async {
    try {
      DocumentSnapshot snapshot =
          await _collectionName.doc(_documentString).get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (data.containsKey(key)) {
        return data[key];
      } else {
        return null;
      }
    } catch (e) {
      print('Failed to get data: $e');
      return null;
    }
  }

  Future<bool> checkSavedWord(String key) async {
    try {
      DocumentSnapshot snapshot =
          await _collectionName.doc(_documentString).get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      return data.containsKey(key);
    } catch (e) {
      print('Failed to get data: $e');
      return false;
    }
  }

  Future<int> getDocumentDataCount(String documentName) async {
    try {
      DocumentSnapshot snapshot = await _collectionName.doc(documentName).get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      return data.length;
    } catch (e) {
      print('Failed to get data: $e');
      return 0;
    }
  }

  Future<List<String>> searchWords(String query) async {
    try {
      final snapshot = await _collectionName.doc(_documentString).get();
      final data = snapshot.data() as Map<String, dynamic>;
      final matchingWords = data.keys
          .where((word) =>
              word.toLowerCase().startsWith(query.toLowerCase().trim()))
          .toList();
      return matchingWords;
    } catch (e) {
      print('Failed to search words: $e');
      return [];
    }
  }

  Future<Map<String, String>?> getMeanings(List<String> words) async {
    try {
      DocumentSnapshot snapshot =
          await _collectionName.doc(_documentString).get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      Map<String, String> meanings = {};

      words.forEach((word) {
        if (data.containsKey(word)) {
          meanings[word] = data[word];
        }
      });

      return meanings.isNotEmpty ? meanings : null;
    } catch (e) {
      print('Failed to get data: $e');
      return null;
    }
  }
}
