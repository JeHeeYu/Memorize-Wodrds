import 'package:flutter/material.dart';
import 'package:memorize_wodrds/src/authentication/authentication_manager.dart';
import 'package:memorize_wodrds/src/screen/login_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthenticationManager authenticationManager = AuthenticationManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Profile Page',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: () async {
                await authenticationManager.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
