import 'package:flutter/material.dart';
import 'package:memorize_wodrds/src/app.dart';
import 'package:memorize_wodrds/src/authentication/authentication_manager.dart';

class OnboardingScreen extends StatelessWidget {
  AuthenticationManager authenticationManager = AuthenticationManager();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: PageView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'First Page',
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Second Page',
                  style: TextStyle(fontSize: 24),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // authenticationManager.checkUserRegistered();
                    // await authenticationManager.signInWithGoogle();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const App()),
                    );
                  },
                  child: const Text('Get Started'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
