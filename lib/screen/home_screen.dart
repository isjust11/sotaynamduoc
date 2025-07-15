import 'package:flutter/material.dart';
import 'package:sotaynamduoc/screen/account_screen.dart';
import 'package:sotaynamduoc/screen/news_screen.dart';
import 'package:sotaynamduoc/screen/settings_screen.dart';
import 'package:get/get.dart';
import 'package:sotaynamduoc/screen/thaoduoc_screen.dart';




class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    _HomeContent(),
    NewsScreen(),
    ThaoDuocScreen(),
    AccountScreen(),
  ];

  final List<String> _titles = [
    'Trang chủ',
    'Tin tức',
    'Cây thuốc',
    'Tài khoản',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        actions: [
          _selectedIndex == 3 ? IconButton(
            onPressed: () {
              Get.to(() => SettingsScreen());
            },
            icon: Icon(Icons.settings),
          ) : SizedBox.shrink(),
        ],
        centerTitle: true,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Tin tức',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_florist),
            label: 'Cây thuốc',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tài khoản',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Trang chủ'));
  }
}
