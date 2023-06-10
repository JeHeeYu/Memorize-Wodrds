import 'package:flutter/material.dart';
import 'package:memorize_wodrds/src/pages/home_page.dart';
import 'package:memorize_wodrds/src/screen/add_sentence_screen.dart';
import 'package:memorize_wodrds/src/screen/add_word_screen.dart';
import 'package:memorize_wodrds/src/screen/list_screen.dart';
import 'package:memorize_wodrds/src/screen/word_search_screen.dart';
import 'package:memorize_wodrds/src/static/strings_data.dart';

enum HomeIcon {
  home,
  addWord,
  addSentence,
  search,
  list,
}

class LeftMenu extends StatelessWidget {
  const LeftMenu({Key? key}) : super(key: key);

  Widget buildListTile(BuildContext context, String title, int index) {
    return ListTile(
      title: Row(
        children: <Widget>[
          const Text(
            '•',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        if (index == HomeIcon.home.index) {
          // index에 따라 화면 이동
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else if (index == HomeIcon.addWord.index) {
          // index에 따라 화면 이동
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddWordScreen()),
          );
        } else if (index == HomeIcon.addSentence.index) {
          // index에 따라 화면 이동
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddSentenceScreen()),
          );
        }else if (index == HomeIcon.search.index) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WordSearchScreen()),
          );
        } else if (index == HomeIcon.list.index) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ListScreen()),
          );
        } else {
          Navigator.pop(context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text(
              Strings.STR_COMMON_MENU,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            automaticallyImplyLeading: false,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  buildListTile(context, Strings.STR_COMMON_HOME, 0),
                  buildListTile(context, Strings.STR_ADD_SCREEN_WORD_ADD, 1),
                  buildListTile(context, Strings.STR_ADD_SCREEN_SENTENCE_ADD, 2),
                  buildListTile(context, Strings.STR_ADD_SCREEN_WORD_SEARCH, 2),
                  buildListTile(context, Strings.STR_ADD_SCREEN_WORD_LIST, 3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
