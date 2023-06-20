import 'package:flutter/material.dart';
import 'package:memorize_wodrds/src/app.dart';
import 'package:memorize_wodrds/src/authentication/authentication_manager.dart';
import 'package:memorize_wodrds/src/screen/login_screen.dart';
import 'package:memorize_wodrds/src/static/images_data.dart';

class OnboardingScreen extends StatelessWidget {
  final AuthenticationManager authenticationManager = AuthenticationManager();

  @override
  Widget build(BuildContext context) {
    Future<void>.delayed(const Duration(seconds: 3)).then((_) async {
      bool isUserRegistered = await authenticationManager.checkUserRegistered();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              isUserRegistered ? const App() : const LoginScreen(),
        ),
      );
    });

    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(89, 155, 188, 1),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Image(
                image: AssetImage(Images.IMG_ONBOARDING_TOP_TEXT),
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              Image(
                image: AssetImage(Images.IMG_ONBOARDING_BOTTOM_TEXT),
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
