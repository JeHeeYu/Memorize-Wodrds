import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:memorize_wodrds/src/components/radio_dialog.dart';
import 'package:memorize_wodrds/src/components/select_dialog.dart';
import 'package:memorize_wodrds/src/network/firebase_manager.dart';
import 'package:memorize_wodrds/src/screens/word_search_screen.dart';

import '../screens/solve_screen.dart';
import '../statics/common_data.dart';
import '../statics/strings_data.dart';

class ItemWidget extends StatelessWidget {
  final IconData iconData;
  final String iconText;
  final MoreList iconListIndex;

  ItemWidget({
    Key? key,
    required this.iconData,
    required this.iconText,
    required this.iconListIndex,
  });

  FirebaseManager firebaseManager = FirebaseManager();

  void Function(int p1)? get settingPopupSelection => null;

  Future<void> changeScreen(BuildContext? context, int index) async {
    if(index == MoreList.search.index) {
      await Navigator.push(
        context!,
        MaterialPageRoute(builder: (context) => const WordSearchScreen()),
      );
    }
    else if (index == MoreList.test.index) {
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
        Strings.STR_MORE_WORD_SENTENCE,
      );
    }
  }

  void favoritePopupSelection(int option, MoreList listIndex) async {
    if(option == 0) {
      firebaseManager.addFavorite(listIndex.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final index = Common.stringList.indexOf(iconText);
        changeScreen(context, index);
      },
      onLongPress: () {
        showSelectDialog(context, (int option) {
          favoritePopupSelection(option, iconListIndex);
        }, Strings.STR_MORE_ADD_FAVORITE);
      },
      child: Column(
        children: [
          Icon(
            iconData,
            size: 50,
          ),
          const SizedBox(height: 10),
          Text(
            iconText,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
