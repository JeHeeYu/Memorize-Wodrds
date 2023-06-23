import 'package:flutter/material.dart';
import 'package:memorize_wodrds/src/statics/strings_data.dart';

enum MoreList { search, test, testSetting, count }

class Common {
  static const int wordType = 0;
  static const int sentenceType = 1;

  static const int questionListMaxCount = 4;

  static final List<IconData> iconList = [
    Icons.search,
    Icons.check_circle_outline,
    Icons.settings_applications_outlined,
  ];

  static final List<String> stringList = [
    Strings.STR_ADD_SCREEN_WORD_LIST,
    Strings.STR_MORE_TEST,
    Strings.STR_MORE_TEST_SETTING,
  ];
}
