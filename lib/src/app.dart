import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:memorize_wodrds/src/controllers/bottom_navigation_controller.dart';
import 'package:memorize_wodrds/src/statics/strings_data.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WillPopScope(
        onWillPop: () async {
          if (currentBackPressTime == null ||
              DateTime.now().difference(currentBackPressTime!) >
                  const Duration(seconds: 2)) {
            currentBackPressTime = DateTime.now();
            Fluttertoast.showToast(
              msg: Strings.STR_HOME_BACK_KEY_TOAST_MESSAGE,
              backgroundColor: Colors.grey,
              toastLength: Toast.LENGTH_SHORT,
            );
            return false;
          }
          return true;
        },
        child: const BottomNavigationController(),
      ),
    );
  }
}
