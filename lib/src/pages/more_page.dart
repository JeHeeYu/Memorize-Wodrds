import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../components/app_bar_widget.dart';
import '../components/left_menu.dart';
import '../static/images_data.dart';
import '../static/strings_data.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  Widget _buildGridItem(AssetImage image, String text) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Image(
              image: image,
              // width: 20,
              // height: 20,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: Strings.STR_PROFILE_MORE,
      ),
      drawer: const LeftMenu(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 3,
          children: [
            _buildGridItem(AssetImage(Images.IMG_ARROW_BOTTOM), 'Item 1'),
            _buildGridItem(AssetImage(Images.IMG_ARROW_BOTTOM), 'Item 1'),
            _buildGridItem(AssetImage(Images.IMG_ARROW_BOTTOM), 'Item 1'),
            // 그리드 아이템을 추가해 나갈 수 있습니다.
          ],
        ),
      ),
    );
  }
}
