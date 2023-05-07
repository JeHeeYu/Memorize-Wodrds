import 'package:flutter/material.dart';
import 'package:memorize_wodrds/src/pages/profile_page.dart';
import 'package:memorize_wodrds/src/pages/search_page.dart';

import '../pages/home_page.dart';

class BottomNavigationController extends StatefulWidget {
  const BottomNavigationController({super.key});

  @override
  State<BottomNavigationController> createState() => _BottomNavigationControllerState();
}

class _BottomNavigationControllerState extends State<BottomNavigationController> {
  int _selectIndex = 0;

  final List<Widget> _pages = <Widget> [
    HomePage(),
    SearchPage(),
    ProfilePage(),
  ];

  void _onBottomTapped(int index) {
    setState(() {
      _selectIndex = index;

      print("selectIndex : ${_selectIndex}");
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
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'profile',
          ),
        ],
      ),
    );
  }
}