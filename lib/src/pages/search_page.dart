import 'package:flutter/material.dart';
import 'package:memorize_wodrds/src/components/app_bar_widget.dart';
import 'package:memorize_wodrds/src/screen/word_search_screen.dart';
import 'package:memorize_wodrds/src/static/strings_data.dart';

import '../components/left_menu.dart';
import '../screen/sentence_search_screen.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: Strings.STR_HOME_WIDGET_SEARCH,
      ),
      drawer: const LeftMenu(),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                child: Text(
                  Strings.STR_COMMON_WORD,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  Strings.STR_COMMON_SENTENCE,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                WordSearchScreen(),
                SentenceSearchScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
