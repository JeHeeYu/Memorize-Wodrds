import 'package:flutter/material.dart';
import 'package:memorize_wodrds/src/authentication/authentication_manager.dart';
import 'package:memorize_wodrds/src/screen/login_screen.dart';

import '../components/app_bar_widget.dart';
import '../components/left_menu.dart';
import '../network/firebase_manager.dart';
import '../static/images_data.dart';
import '../static/strings_data.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthenticationManager authenticationManager = AuthenticationManager();
  final FirebaseManager firebaseManager = FirebaseManager();

  Future<String?> getEmail() async {
    String? email = await firebaseManager.getUserEmail();
    return email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: Strings.STR_PROFILE_MENU,
      ),
      drawer: const LeftMenu(),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Stack(
                children: [
                  const Image(
                    image: AssetImage(Images.IMG_BG_RADIUS_WHITE),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                Strings.STR_PROFILE_CURRENT_ACCOUNT,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          FutureBuilder<String?>(
                            future: getEmail(),
                            builder: (BuildContext context,
                                AsyncSnapshot<String?> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return const Text('Error');
                              } else {
                                return Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    snapshot.data ?? '',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () async {
                await authenticationManager.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      Strings.STR_PROFILE_SIGN_OUT,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 60),
                    child: Image(
                      image: AssetImage(Images.IMG_ARROW_RIGHT),
                      width: 20,
                      height: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
