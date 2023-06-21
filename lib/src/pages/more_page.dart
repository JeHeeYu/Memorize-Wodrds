import 'package:flutter/material.dart';

import '../statics/strings_data.dart';

class MorePage extends StatelessWidget {
  const MorePage({Key? key}) : super(key: key);

  Widget _buildGridItem(IconData iconData, String text, int index) {
    return GestureDetector(
      onTap: () {
        print('jehee Test : $index');
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

  @override
  Widget build(BuildContext context) {
    final List<IconData> iconList = [
      Icons.check_circle_outline,
      Icons.favorite_border,
      Icons.star_border,
      Icons.thumb_up,
    ];

    final List<String> stringList = [
      Strings.STR_MORE_TEST,
      Strings.STR_MORE_TEST,
      Strings.STR_MORE_TEST,
      Strings.STR_MORE_TEST,
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
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return _buildGridItem(iconList[index], stringList[index], index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
