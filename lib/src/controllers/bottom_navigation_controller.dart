import 'package:flutter/material.dart';
import 'package:memorize_wodrds/src/pages/profile_page.dart';
import 'package:memorize_wodrds/src/pages/search_page.dart';
import 'package:memorize_wodrds/src/static/strings_data.dart';
import '../pages/home_page.dart';

class BottomNavigationController extends StatefulWidget {
  const BottomNavigationController({super.key});

  @override
  State<BottomNavigationController> createState() =>
      _BottomNavigationControllerState();
}

class _BottomNavigationControllerState
    extends State<BottomNavigationController> {
  int _selectIndex = 0;

  final List<Widget> _pages = <Widget>[
    const HomePage(),
    const SearchPage(),
    const ProfilePage(),
  ];

  void _onBottomTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectIndex,
        onTap: _onBottomTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: Strings.STR_BOTTOM_TAB_HOME,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: Strings.STR_BOTTOM_TAB_SEARCH,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: Strings.STR_BOTTOM_TAB_PROFILE,
          ),
        ],
        selectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}
