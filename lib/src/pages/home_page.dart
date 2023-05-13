import 'package:flutter/material.dart';
import 'package:memorize_wodrds/src/components/app_bar_widget.dart';
import 'package:memorize_wodrds/src/components/left_menu.dart';
import 'package:memorize_wodrds/src/components/select_dialog.dart';
import 'package:memorize_wodrds/src/network/firebase_manager.dart';
import 'package:memorize_wodrds/src/screen/add_screen.dart';
import 'package:memorize_wodrds/src/screen/list_screen.dart';
import 'package:memorize_wodrds/src/screen/search_screen.dart';
import 'package:memorize_wodrds/src/static/images_data.dart';
import 'package:memorize_wodrds/src/static/strings_data.dart';

enum HomeIcon {
  add,
  search,
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int documentCount = 0;

  Widget homeWidgetImage(int index) {
    AssetImage imageAsset;

    if (index == HomeIcon.add.index) {
      imageAsset = const AssetImage(Images.IMG_HOME_ADD_BUTTON);
    } else if (index == HomeIcon.search.index) {
      imageAsset = const AssetImage(Images.IMG_HOME_SEARCH_BUTTON);
    } else if (index == HomeIcon.add.index) {
      imageAsset = const AssetImage(Images.IMG_HOME_ADD_BUTTON);
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
    } else {
      return const Text(Strings.STR_HOME_WIDGET_SEARCH);
    }
  }

  Future<void> navigateToAddScreen(BuildContext? context, int index) async {
    if (index == HomeIcon.add.index) {
      await Navigator.push(
        context!,
        MaterialPageRoute(builder: (context) => const AddScreen()),
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
                children: const [
                  Text(
                    "지금까지 알게 된 단어는 XX개 입니다.",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "지금까지 알게 된 문장은 XX개 입니다.",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return GridTile(
                  child: GestureDetector(
                    onTap: () async {
                      print("click event : $index");
                      // final int? result = await showDialog<int>(
                      //   context: context,
                      //   builder: (BuildContext context) => const PopupDialog(),
                      // );
                      await navigateToAddScreen(context, index);
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
        ],
      ),
    );
  }
}
