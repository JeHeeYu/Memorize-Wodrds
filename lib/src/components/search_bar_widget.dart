import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final ValueChanged<String> onSearch;
  final TextEditingController controller;

  const SearchBarWidget({
    Key? key,
    required this.onSearch,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Search',
        suffixIcon: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            onSearch(controller.text);
          },
        ),
      ),
      onChanged: onSearch,
    );
  }
}