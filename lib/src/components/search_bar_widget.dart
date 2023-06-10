import 'package:flutter/material.dart';
import 'package:memorize_wodrds/src/static/strings_data.dart';

class SearchBarWidget extends StatefulWidget {
  final ValueChanged<String> onSearch;
  final TextEditingController controller;

  const SearchBarWidget({
    Key? key,
    required this.onSearch,
    required this.controller,
  }) : super(key: key);

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  void initState() {
    super.initState();
    
    widget.onSearch(widget.controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: false,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: Strings.STR_ADD_SEARCH_HINT,
        suffixIcon: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            widget.onSearch(widget.controller.text);
          },
        ),  
      ),
      onChanged: widget.onSearch,
    );
  }
}