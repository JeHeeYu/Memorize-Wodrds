import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:memorize_wodrds/src/authentication/authentication_manager.dart';
import 'package:memorize_wodrds/src/static/strings_data.dart';
import 'package:yaml/yaml.dart';

class FirebaseManager {
  late FirebaseFirestore _firestore;

  final AuthenticationManager auto = AuthenticationManager();

  FirebaseManager() {
    _firestore = FirebaseFirestore.instance;
    _initialize();
  }

  Future<void> _initialize() async {}

    Future<String?> getUserName() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      final userDocRef = FirebaseFirestore.instance
          .collection(Strings.STR_FIRESTORE_USERS_COLLECTION)
          .doc(currentUser!.uid);

      final userDocSnapshot = await userDocRef.get();
      final userData = userDocSnapshot.data() as Map<String, dynamic>?;

      if (userData != null && userData.containsKey("name")) {
        return userData["name"];
      } else {
        return null;
      }
    } catch (e) {
      print('Failed to get user data: $e');
      return null;
    }
  }


  Future<void> addWord(Map<String, dynamic> data) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      final userDocRef = FirebaseFirestore.instance
          .collection(Strings.STR_FIRESTORE_USERS_COLLECTION)
          .doc(currentUser!.uid);
      final dataColRef =
          userDocRef.collection(Strings.STR_FIRESTORE_DATA_COLLECTION);
      final wordDocRef = dataColRef.doc(Strings.STR_FIRESTORE_WORDS_FIELD);

      final wordDocSnapshot = await wordDocRef.get();
      final wordData = wordDocSnapshot.data() as Map<String, dynamic>?;

      if (wordData != null) {
        data.addAll(wordData);
      }

      //await auto.signInWithGoogle();

      await wordDocRef.set(data);
      print('Data added');
    } catch (e) {
      print('Failed to add data: $e');
    }
  }

  Future<void> addSentence(Map<String, dynamic> data) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      final userDocRef = FirebaseFirestore.instance
          .collection(Strings.STR_FIRESTORE_USERS_COLLECTION)
          .doc(currentUser!.uid);
      final dataColRef =
          userDocRef.collection(Strings.STR_FIRESTORE_DATA_COLLECTION);
      final wordDocRef = dataColRef.doc(Strings.STR_FIRESTORE_SENTENCES_FILED);

      final wordDocSnapshot = await wordDocRef.get();
      final wordData = wordDocSnapshot.data() as Map<String, dynamic>?;

      if (wordData != null) {
        data.addAll(wordData);
      }

      //await auto.signInWithGoogle();

      await wordDocRef.set(data);
      print('Data added');
    } catch (e) {
      print('Failed to add data: $e');
    }
  }

  Future<String?> readMeaning(String key) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      final userDocRef = FirebaseFirestore.instance
          .collection(Strings.STR_FIRESTORE_USERS_COLLECTION)
          .doc(currentUser!.uid);
      final dataColRef =
          userDocRef.collection(Strings.STR_FIRESTORE_DATA_COLLECTION);
      final wordDocRef = dataColRef.doc(Strings.STR_FIRESTORE_WORDS_FIELD);

      final wordDocSnapshot = await wordDocRef.get();
      final wordData = wordDocSnapshot.data() as Map<String, dynamic>?;

      if (wordData != null && wordData.containsKey(key)) {
        return wordData[key];
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
      final currentUser = FirebaseAuth.instance.currentUser;
      final userDocRef = FirebaseFirestore.instance
          .collection(Strings.STR_FIRESTORE_USERS_COLLECTION)
          .doc(currentUser!.uid);
      final dataColRef =
          userDocRef.collection(Strings.STR_FIRESTORE_DATA_COLLECTION);
      final wordDocRef = dataColRef.doc(Strings.STR_FIRESTORE_WORDS_FIELD);
      final wordDocSnapshot = await wordDocRef.get();
      final wordData = wordDocSnapshot.data() as Map<String, dynamic>?;
      return wordData?.containsKey(key) ?? false;
    } catch (e) {
      print('Failed to get data: $e');
      return false;
    }
  }

  Future<int> getWordCount() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      final userDocRef =
          FirebaseFirestore.instance.collection(Strings.STR_FIRESTORE_USERS_COLLECTION).doc(currentUser!.uid);
      final dataColRef = userDocRef.collection(Strings.STR_FIRESTORE_DATA_COLLECTION);
      final wordDocSnapshot = await dataColRef.doc(Strings.STR_FIRESTORE_WORDS_FIELD).get();

      final wordData = wordDocSnapshot.data() as Map<String, dynamic>?;
      if (wordData == null) {
        return 0;
      } else {
        return wordData.length;
      }
    } catch (e) {
      print('Failed to get data: $e');
      return 0;
    }
  }

    Future<int> getSentenceCount() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      final userDocRef =
          FirebaseFirestore.instance.collection(Strings.STR_FIRESTORE_USERS_COLLECTION).doc(currentUser!.uid);
      final dataColRef = userDocRef.collection(Strings.STR_FIRESTORE_DATA_COLLECTION);
      final sentenceDocSnapshot = await dataColRef.doc(Strings.STR_FIRESTORE_SENTENCES_FILED).get();

      final wordData = sentenceDocSnapshot.data() as Map<String, dynamic>?;
      if (wordData == null) {
        return 0;
      } else {
        return wordData.length;
      }
    } catch (e) {
      print('Failed to get data: $e');
      return 0;
    }
  }

  Future<List<String>> searchWords(String query) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      final userDocRef = FirebaseFirestore.instance
          .collection(Strings.STR_FIRESTORE_USERS_COLLECTION)
          .doc(currentUser!.uid);
      final dataColRef =
          userDocRef.collection(Strings.STR_FIRESTORE_DATA_COLLECTION);
      final wordDocRef = dataColRef.doc(Strings.STR_FIRESTORE_WORDS_FIELD);
      final wordDocSnapshot = await wordDocRef.get();
      final wordData = wordDocSnapshot.data() as Map<String, dynamic>?;
      final matchingWords = wordData?.keys
          .where((word) =>
              word.toLowerCase().startsWith(query.toLowerCase().trim()))
          .toList();
      return matchingWords ?? [];
    } catch (e) {
      print('Failed to search words: $e');
      return [];
    }
  }

  Future<Map<String, String>?> getMeanings(List<String> words) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      final userDocRef = FirebaseFirestore.instance
          .collection(Strings.STR_FIRESTORE_USERS_COLLECTION)
          .doc(currentUser!.uid);
      final dataColRef =
          userDocRef.collection(Strings.STR_FIRESTORE_DATA_COLLECTION);
      final wordDocRef = dataColRef.doc(Strings.STR_FIRESTORE_WORDS_FIELD);
      final wordDocSnapshot = await wordDocRef.get();
      final wordData = wordDocSnapshot.data() as Map<String, dynamic>?;
      Map<String, String> meanings = {};

      words.forEach((word) {
        if (wordData?.containsKey(word) == true) {
          meanings[word] = wordData![word];
        }
      });

      return meanings.isNotEmpty ? meanings : null;
    } catch (e) {
      print('Failed to get data: $e');
      return null;
    }
  }
}
