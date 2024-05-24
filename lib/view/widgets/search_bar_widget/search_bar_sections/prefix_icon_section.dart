import 'package:flutter/material.dart';

class SearchBarPrefixIconSection extends StatelessWidget {
  const SearchBarPrefixIconSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Icon(Icons.search_rounded),
      ),
    );
  }
}
