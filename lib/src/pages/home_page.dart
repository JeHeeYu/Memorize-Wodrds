import 'package:flutter/material.dart';
import 'package:memorize_wodrds/src/components/select_dialog.dart';
import 'package:memorize_wodrds/src/screen/add_screen.dart';
import 'package:memorize_wodrds/src/static/images_data.dart';
import 'package:memorize_wodrds/src/static/strings_data.dart';

enum HomeIcon {
  add,
  search,
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget homeWidgetImage(int index) {
    AssetImage imageAsset;

    if (index == HomeIcon.add.index) {
      imageAsset = const AssetImage(Images.IMG_HOME_ADD_BUTTON);
    } 
    else if (index == HomeIcon.search.index) {
      imageAsset = const AssetImage(Images.IMG_HOME_SEARCH_BUTTON);
    } 
    else if (index == HomeIcon.add.index) {
      imageAsset = const AssetImage(Images.IMG_HOME_ADD_BUTTON);
    } 
    else {
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
    } 
    else if (index == HomeIcon.search.index) {
      return const Text(Strings.STR_HOME_WIDGET_SEARCH);
    } 
    else {
      return const Text(Strings.STR_HOME_WIDGET_SEARCH);
    }
  }

  Future<void> navigateToAddScreen(BuildContext? context) async {
    await Navigator.push(
      context!,
      MaterialPageRoute(builder: (context) => const AddScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 65),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: GestureDetector(
              onTap: () async {
                print("click event : ${index}");

                final int? result = await showDialog<int>(
                  context: context,
                  builder: (BuildContext context) {
                    return const PopupDialog();
                  },
                );

                if (result == 0) {
                  await navigateToAddScreen(context);
                } else {
                  print("1");
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
    );
  }
}
