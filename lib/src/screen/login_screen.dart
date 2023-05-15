import 'package:flutter/material.dart';
import 'package:memorize_wodrds/src/authentication/authentication_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthenticationManager authenticationManager = AuthenticationManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login Screen',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: () async {
                await authenticationManager.signInWithGoogle();
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}