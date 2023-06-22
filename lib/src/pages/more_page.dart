import 'package:flutter/material.dart';
import 'package:memorize_wodrds/src/components/radio_dialog.dart';

import '../screens/solve_screen.dart';
import '../statics/strings_data.dart';

enum MoreList { test, testSetting, count }

class MorePage extends StatelessWidget {
  const MorePage({Key? key}) : super(key: key);

  Widget _buildGridItem(
      BuildContext context, IconData iconData, String text, int index) {
    return GestureDetector(
      onTap: () {
        changeScreen(context, index);
      },
      child: Container(
        child: Column(
          children: [
            Icon(
              iconData,
              size: 50,
            ),
            const SizedBox(height: 10),
            Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> changeScreen(BuildContext? context, int index) async {
    if (index == MoreList.test.index) {
      await Navigator.push(
        context!,
        MaterialPageRoute(builder: (context) => const SolveScreen()),
      );
    } else if (index == MoreList.testSetting.index) {
      showRadioDialog(
          context!,
          settingPopupSelection,
          Strings.STR_MORE_TEST_SETTING_DIALOG_TEST,
          Strings.STR_COMMON_WORD,
          Strings.STR_COMMON_SENTENCE,
          Strings.STR_MORE_WORD_SENTENCE);
    }
  }

  void settingPopupSelection(int option) {
  }

  @override
  Widget build(BuildContext context) {
    final List<IconData> iconList = [
      Icons.check_circle_outline,
      Icons.settings_applications_outlined,
    ];

    final List<String> stringList = [
      Strings.STR_MORE_TEST,
      Strings.STR_MORE_TEST_SETTING,
    ];

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
                  return _buildGridItem(
                      context, iconList[index], stringList[index], index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
