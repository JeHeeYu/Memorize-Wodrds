import 'dart:math';

import 'package:flutter/material.dart';
import 'package:memorize_wodrds/src/components/app_bar_widget.dart';
import 'package:memorize_wodrds/src/components/left_menu.dart';
import 'package:memorize_wodrds/src/static/images_data.dart';
import 'package:memorize_wodrds/src/static/strings_data.dart';

class ListScreen extends StatelessWidget {
  static final List<String> imagesPath = [
    Images.IMG_SEARCH_SCREEN_A,
    Images.IMG_SEARCH_SCREEN_B,
    Images.IMG_SEARCH_SCREEN_C,
    Images.IMG_SEARCH_SCREEN_D,
    Images.IMG_SEARCH_SCREEN_E,
    Images.IMG_SEARCH_SCREEN_F,
    Images.IMG_SEARCH_SCREEN_G,
    Images.IMG_SEARCH_SCREEN_H,
    Images.IMG_SEARCH_SCREEN_I,
    Images.IMG_SEARCH_SCREEN_J,
    Images.IMG_SEARCH_SCREEN_K,
    Images.IMG_SEARCH_SCREEN_L,
    Images.IMG_SEARCH_SCREEN_M,
    Images.IMG_SEARCH_SCREEN_N,
    Images.IMG_SEARCH_SCREEN_O,
    Images.IMG_SEARCH_SCREEN_P,
    Images.IMG_SEARCH_SCREEN_Q,
    Images.IMG_SEARCH_SCREEN_R,
    Images.IMG_SEARCH_SCREEN_S,
    Images.IMG_SEARCH_SCREEN_T,
    Images.IMG_SEARCH_SCREEN_U,
    Images.IMG_SEARCH_SCREEN_V,
    Images.IMG_SEARCH_SCREEN_W,
    Images.IMG_SEARCH_SCREEN_X,
    Images.IMG_SEARCH_SCREEN_Y,
    Images.IMG_SEARCH_SCREEN_Z,
  ];

  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: Strings.STR_ADD_SCREEN_WORD_LIST,
      ),
      drawer: const LeftMenu(),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 가로 방향에 표시할 개수
            crossAxisSpacing: 30.0, // 이미지 간 가로 간격
            mainAxisSpacing: 70.0, // 이미지 간 세로 간격
          ),
          itemCount: imagesPath.length, // 전체 이미지 수
          itemBuilder: (BuildContext context, int index) {
            final random = Random();
            final angle = random.nextInt(41) - 20;
            return Transform.rotate(
              angle: angle * pi / 180,
              child: Image.asset(
                imagesPath[index],
                fit: BoxFit.cover,
                width: 10,
                height: 10,
              ),
            );
          },
        ),
      ),
    );
  }
}
