import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memorize_wodrds/src/components/app_bar_widget.dart';
import 'package:memorize_wodrds/src/components/left_menu.dart';
import 'package:memorize_wodrds/src/components/select_dialog.dart';
import 'package:memorize_wodrds/src/components/border_radius_widget.dart';
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

  String getCurrentDate() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    String currentDate = getCurrentDate();

    return Scaffold(
      appBar: const AppBarWidget(
        title: Strings.STR_COMMON_HOME,
      ),
      drawer: const LeftMenu(),
      //backgroundColor: Colors.grey,
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    currentDate,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                const Image(
                  image: AssetImage(Images.IMG_ARROW_BOTTOM),
                  width: 15,
                  height: 10,
                ),
              ],
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FutureBuilder<String?>(
                    future: firebaseManager.getUserName(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasData) {
                        String userName = snapshot.data ?? '';

                        TextStyle userNameStyle = const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        );

                        TextStyle textStyle = const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        );

                        return RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: Strings.STR_HOME_HELLO_START_TEXT,
                                  style: textStyle),
                              TextSpan(text: userName, style: userNameStyle),
                              TextSpan(
                                  text: Strings.STR_HOME_HELLO_END_TEXT,
                                  style: textStyle),
                              const TextSpan(text: '\n'),
                              TextSpan(
                                  text: Strings.STR_HOME_WELLCOME_TEXT,
                                  style: textStyle),
                            ],
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  Stack(
                    children: [
                      const Image(
                        image: AssetImage(Images.IMG_BG_RADIUS_WHITE),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: FutureBuilder<int>(
                            future: firebaseManager.getWordCount(),
                            builder: (context, wordSnapshot) {
                              if (wordSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (wordSnapshot.hasData) {
                                int wordCount = wordSnapshot.data ?? 0;

                                return FutureBuilder<int>(
                                  future: firebaseManager.getSentenceCount(),
                                  builder: (context, sentenceSnapshot) {
                                    if (sentenceSnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (sentenceSnapshot.hasData) {
                                      int sentenceCount =
                                          sentenceSnapshot.data ?? 0;

                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${Strings.STR_HOME_WORD_COUNT}${wordCount.toString()}${Strings.STR_HOME_COMMON_COUNT}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            '${Strings.STR_HOME_SENTENCE_COUNT}${sentenceCount.toString()}${Strings.STR_HOME_COMMON_COUNT}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    return const SizedBox(); // 데이터가 없을 때는 빈 컨테이너 반환
                                  },
                                );
                              }
                              return const SizedBox(); // 데이터가 없을 때는 빈 컨테이너 반환
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              const Image(
                                image: AssetImage(Images.IMG_BG_RADIUS_WHITE),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  selectIndex = 0;
                                  await navigateToScreen(
                                      context, HomeIcon.add.index);
                                },
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        Strings.STR_ADD_SCREEN_WORD_ADD,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Image(
                                        image:
                                            AssetImage(Images.IMG_ARROW_RIGHT),
                                        width: 20,
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Stack(
                            children: [
                              const Image(
                                image: AssetImage(Images.IMG_BG_RADIUS_WHITE),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  selectIndex = 1;
                                  await navigateToScreen(
                                      context, HomeIcon.add.index);
                                },
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        Strings.STR_ADD_SCREEN_SENTENCE_ADD,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Image(
                                        image:
                                            AssetImage(Images.IMG_ARROW_RIGHT),
                                        width: 20,
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const BorderRadiusStack(
              imageAsset: Images.IMG_BG_RADIUS_WHITE,
              text: Strings.STR_ADD_SCREEN_SENTENCE_ADD,
            ),
          ],
        ),
      ),
    );
  }
}
