import 'package:flutter/material.dart';
import 'package:sotaynamduoc/screen/news_screen.dart';
import 'package:sotaynamduoc/ui/screen/baithuoc/thaoduoc_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  final List<Widget> _screens = [
    _HomeContent(),
    NewsScreen(),
    // ThaoDuocScreen(),
    // AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return _HomeContent();
  }
}

class _HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Trang chủ'));
  }
}
