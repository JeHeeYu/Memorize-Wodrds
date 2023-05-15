import 'package:flutter/material.dart';
import 'package:memorize_wodrds/src/app.dart';
import 'package:memorize_wodrds/src/authentication/authentication_manager.dart';
import 'package:memorize_wodrds/src/screen/login_screen.dart';

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
                    bool isUserRegistered =
                        await authenticationManager.checkUserRegistered();

                    if (isUserRegistered == false) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const App()),
                      );
                    }
                    // authenticationManager.checkUserRegistered();
                    // await authenticationManager.signInWithGoogle();
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
