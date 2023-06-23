import 'package:flutter/material.dart';
import 'package:memorize_wodrds/src/components/radio_dialog.dart';
import 'package:memorize_wodrds/src/network/firebase_manager.dart';
import 'package:memorize_wodrds/src/screens/word_search_screen.dart';

import '../components/item_widget.dart';
import '../components/select_dialog.dart';
import '../screens/solve_screen.dart';
import '../statics/common_data.dart';
import '../statics/strings_data.dart';

class MorePage extends StatelessWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  Strings.STR_MORE_TITLE,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(
              height: 30,
              thickness: 2,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 60,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount: MoreList.count.index,
                itemBuilder: (BuildContext context, int index) {
                  return ItemWidget(
                    iconData: Common.iconList[index],
                    iconText: Common.stringList[index],
                    iconListIndex: MoreList.values[index]
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
