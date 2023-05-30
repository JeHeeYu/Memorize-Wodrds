import 'package:flutter/material.dart';
import 'package:memorize_wodrds/src/components/app_bar_widget.dart';
import 'package:memorize_wodrds/src/components/left_menu.dart';
import 'package:memorize_wodrds/src/components/select_dialog.dart';
import 'package:memorize_wodrds/src/network/firebase_manager.dart';
import 'package:memorize_wodrds/src/screen/add_sentence_screen.dart';
import 'package:memorize_wodrds/src/screen/add_word_screen.dart';
import 'package:memorize_wodrds/src/screen/list_screen.dart';
import 'package:memorize_wodrds/src/screen/search_screen.dart';
import 'package:memorize_wodrds/src/static/images_data.dart';
import 'package:memorize_wodrds/src/static/strings_data.dart';

enum HomeIcon {
  add,
  search,
  list,
}

enum AddType {
  word,
  sentence,
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int? selectIndex = 0;

  final FirebaseManager firebaseManager = FirebaseManager();

  Widget homeWidgetImage(int index) {
    AssetImage imageAsset;

    if (index == HomeIcon.add.index) {
      imageAsset = const AssetImage(Images.IMG_HOME_ADD_BUTTON);
    } else if (index == HomeIcon.search.index) {
      imageAsset = const AssetImage(Images.IMG_HOME_SEARCH_BUTTON);
    } else if (index == HomeIcon.list.index) {
      imageAsset = const AssetImage(Images.IMG_HOME_LIST);
    } else {
      imageAsset = const AssetImage(Images.IMG_HOME_SEARCH_BUTTON);
    }
    return Expanded(
      child: Image(
        image: imageAsset,
      ),
    );
  }

  Widget homeWidgetString(int index) {
    if (index == HomeIcon.add.index) {
      return const Text(Strings.STR_HOME_WIDGET_ADD);
    } else if (index == HomeIcon.search.index) {
      return const Text(Strings.STR_HOME_WIDGET_SEARCH);
    } else if (index == HomeIcon.list.index) {
      return const Text(Strings.STR_HOME_WIDGET_LIST);
    } else {
      return const Text(Strings.STR_HOME_WIDGET_SEARCH);
    }
  }

  Future<void> navigateToScreen(BuildContext? context, int index) async {
    if (index == HomeIcon.add.index) {
      if (selectIndex == AddType.word.index) {
        await Navigator.push(
          context!,
          MaterialPageRoute(builder: (context) => const AddWordScreen()),
        );
      } else {
        await Navigator.push(
          context!,
          MaterialPageRoute(builder: (context) => const AddSentenceScreen()),
        );
      }
    } else if (index == HomeIcon.list.index) {
      await Navigator.push(
        context!,
        MaterialPageRoute(builder: (context) => const ListScreen()),
      );
    } else {
      await Navigator.push(
        context!,
        MaterialPageRoute(builder: (context) => const SearchScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: Strings.STR_COMMON_HOME,
      ),
      drawer: const LeftMenu(),
      body: Column(
        children: [
          Container(
            height: 100,
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFF3F6FB),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder<int>(
                    future: firebaseManager.getWordCount(),
                    builder:
                        (BuildContext context, AsyncSnapshot<int> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Text(
                          '${Strings.STR_HOME_WORD_COUNT}${snapshot.data.toString()}${Strings.STR_HOME_COMMON_COUNT}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  FutureBuilder<int>(
                    future: firebaseManager.getSentenceCount(),
                    builder:
                        (BuildContext context, AsyncSnapshot<int> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Text(
                          '${Strings.STR_HOME_SENTENCE_COUNT}${snapshot.data.toString()}${Strings.STR_HOME_COMMON_COUNT}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return GridTile(
                    child: GestureDetector(
                      onTap: () async {
                        if (index == HomeIcon.add.index) {
                          selectIndex = await showDialog<int>(
                            context: context,
                            builder: (BuildContext context) =>
                                const PopupDialog(),
                          );

                          if (selectIndex == null) {
                            return;
                          } else {
                            await navigateToScreen(context, index);
                          }
                        }
                        else {
                          await navigateToScreen(context, index);
                        }
                      },
                      child: Column(
                        children: [
                          homeWidgetImage(index),
                          homeWidgetString(index),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
