import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memorize_wodrds/src/components/app_bar_widget.dart';
import 'package:memorize_wodrds/src/components/left_menu.dart';
import 'package:memorize_wodrds/src/components/schedule_dialog.dart';
import 'package:memorize_wodrds/src/components/select_dialog.dart';
import 'package:memorize_wodrds/src/components/border_radius_widget.dart';
import 'package:memorize_wodrds/src/network/firebase_manager.dart';
import 'package:memorize_wodrds/src/screens/add_sentence_screen.dart';
import 'package:memorize_wodrds/src/screens/add_word_screen.dart';
import 'package:memorize_wodrds/src/screens/list_screen.dart';
import 'package:memorize_wodrds/src/screens/word_search_screen.dart';
import 'package:memorize_wodrds/src/statics/images_data.dart';
import 'package:memorize_wodrds/src/statics/strings_data.dart';
import 'package:memorize_wodrds/src/screens/login_screen.dart';

import '../components/item_widget.dart';
import '../screens/solve_screen.dart';
import '../statics/common_data.dart';

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

  late List<int> favoriteList = [];

  final FirebaseManager firebaseManager = FirebaseManager();

  @override
  void initState() {
    super.initState();
    loadFavoriteItems();
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
        MaterialPageRoute(builder: (context) => const WordSearchScreen()),
      );
    }
  }

  String getCurrentDate() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(now);
  }

  Future<void> loadFavoriteItems() async {
    final favoriteFields = [
      Strings.STR_FIRESTORE_FIRST_FAVORITE_FIELD,
      Strings.STR_FIRESTORE_SECOND_FAVORITE_FIELD,
      Strings.STR_FIRESTORE_THIRD_FAVORITE_FIELD,
      Strings.STR_FIRESTORE_FOUR_FAVORITE_FIELD
    ];

    for (final field in favoriteFields) {
      final value = await firebaseManager.readFavoriteValue(field);

      if (value == -1) {
        return; 
      }
      
      setState(() {
        favoriteList.add(value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: Strings.STR_COMMON_HOME,
      ),
      drawer: const LeftMenu(),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    ScheduleDialog.show(context);
                  },
                  child: Text(
                    getCurrentDate(),
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
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
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
                          child: StreamBuilder<int>(
                            stream: firebaseManager.getWordCount(),
                            builder: (context, wordSnapshot) {
                              if (wordSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (wordSnapshot.hasData) {
                                int wordCount = wordSnapshot.data ?? 0;

                                return StreamBuilder<int>(
                                  stream: firebaseManager.getSentenceCount(),
                                  builder: (context, sentenceSnapshot) {
                                    if (sentenceSnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    } else if (sentenceSnapshot.hasData) {
                                      int sentenceCount =
                                          sentenceSnapshot.data ?? 0;

                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                Strings.STR_HOME_WORD_COUNT,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                wordCount.toString(),
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              const Text(
                                                Strings.STR_HOME_COMMON_COUNT,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 15),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                Strings.STR_HOME_SENTENCE_COUNT,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                sentenceCount.toString(),
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              const Text(
                                                Strings.STR_HOME_COMMON_COUNT,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    }
                                    return const SizedBox();
                                  },
                                );
                              }
                              return const SizedBox();
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
                              Positioned.fill(
                                child: InkWell(
                                  onTap: () async {
                                    setState(() {
                                      selectIndex = 0;
                                    });
                                    await navigateToScreen(
                                        context, HomeIcon.add.index);
                                  },
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          image: AssetImage(
                                              Images.IMG_ARROW_RIGHT),
                                          width: 20,
                                          height: 20,
                                        ),
                                      ],
                                    ),
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
                              Positioned.fill(
                                child: InkWell(
                                  onTap: () async {
                                    setState(() {
                                      selectIndex = 1;
                                    });
                                    await navigateToScreen(
                                        context, HomeIcon.add.index);
                                  },
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          image: AssetImage(
                                              Images.IMG_ARROW_RIGHT),
                                          width: 20,
                                          height: 20,
                                        ),
                                      ],
                                    ),
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
            const Divider(
              height: 60,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Icon(
                    Icons.star_border_outlined,
                    size: 30,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    Strings.STR_HOME_FAVORITE,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                favoriteList.length,
                (index) => ItemWidget(
                  iconData: Common.iconList[favoriteList[index]],
                  iconText: Common.stringList[favoriteList[index]],
                  iconListIndex: MoreList.values[favoriteList[index]],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
