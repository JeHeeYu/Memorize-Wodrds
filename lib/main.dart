import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:memorize_wodrds/src/app.dart';
import 'package:memorize_wodrds/src/screen/onboarding_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(color: Colors.black),
        )
      ),
      //home: const App(),
      home: OnboardingScreen(),
    );
  }
}