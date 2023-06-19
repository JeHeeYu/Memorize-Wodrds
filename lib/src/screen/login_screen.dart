import 'package:flutter/material.dart';
import 'package:memorize_wodrds/src/app.dart';
import 'package:memorize_wodrds/src/authentication/authentication_manager.dart';

import '../static/images_data.dart';
import '../static/strings_data.dart';

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
      backgroundColor: const Color.fromRGBO(89, 155, 188, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage(Images.IMG_ONBOARDING_TOP_TEXT),
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            const Image(
              image: AssetImage(Images.IMG_ONBOARDING_BOTTOM_TEXT),
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 80),
            GestureDetector(
              onTap: () async {
                await authenticationManager.signInWithGoogle();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const App()),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: const [
                        Image(
                          image: AssetImage(Images.IMG_GOOGLE_LOGO),
                          width: 40,
                          height: 40,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Text(
                            Strings.STR_LOGIN_GOOGLE,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
