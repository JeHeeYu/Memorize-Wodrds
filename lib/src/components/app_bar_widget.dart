import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      titleSpacing: 0,
      backgroundColor: Colors.white,
      elevation: 1,
      leading: IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          color: Colors.grey,
        ),
      ),
      
      // actions: [
      //     Padding(
      //       padding: const EdgeInsets.symmetric(
      //         horizontal: 30,
      //         vertical: 15,
      //       ),
      //       child: const Text(
      //         "추가",
      //         style: TextStyle(
      //           color: Colors.black,
      //           fontWeight: FontWeight.bold,
      //           fontSize: 16,
      //         ),
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.symmetric(
      //         horizontal: 30,
      //         vertical: 15,
      //       ),
      //       child: Text(
      //         'W',
      //         style: TextStyle(
      //           color: Colors.black,
      //           fontWeight: FontWeight.bold,
      //           fontSize: 16,
      //         ),
      //       ),
      //     ),
      //   ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
