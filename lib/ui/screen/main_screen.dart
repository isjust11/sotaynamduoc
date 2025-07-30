import 'package:flutter/material.dart';
import 'package:sotaynamduoc/ui/screen/baithuoc/thaoduoc_screen.dart';
import 'package:sotaynamduoc/ui/screen/caythuoc/caythuoc_screen.dart';
import 'package:sotaynamduoc/ui/screen/home/home_screen.dart';
import 'package:sotaynamduoc/ui/screen/news/news_list_screen.dart';
import 'package:sotaynamduoc/ui/screen/setting/settings_screen.dart';
import 'package:sotaynamduoc/ui/widget/custom_bottom_navigation_bar.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    HomeScreen(),
    const NewsListScreen(),
    BaithuocScreen(),
    CaythuocScreen(),
    SettingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      hideAppBar: true,
      body: _pages[_selectedIndex],
      floatingButton: null,
      customAppBar: null,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
