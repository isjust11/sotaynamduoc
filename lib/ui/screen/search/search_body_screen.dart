import 'package:flutter/material.dart';

class SearchBodyScreen extends StatefulWidget {
  const SearchBodyScreen({super.key});

  @override
  State<SearchBodyScreen> createState() => _SearchBodyScreenState();
}

class _SearchBodyScreenState extends State<SearchBodyScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Search'));
  }
}
