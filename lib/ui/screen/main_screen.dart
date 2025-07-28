import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/screen/home_screen.dart';
import 'package:sotaynamduoc/ui/screen/baithuoc/thaoduoc_screen.dart';
import 'package:sotaynamduoc/ui/screen/caythuoc/caythuoc_screen.dart';
import 'package:sotaynamduoc/ui/screen/news/news_list_screen.dart';
import 'package:sotaynamduoc/ui/widget/custom_bottom_navigation_bar.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';
import 'package:sotaynamduoc/blocs/news/news.dart';
import 'package:sotaynamduoc/injection_container.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    HomeScreen(),
    CaythuocScreen(),
    const NewsListScreen(),
    BaithuocScreen(),
    // SettingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<NewsBloc>(),
      child: BaseScreen(
        hideAppBar: true,
        body: _pages[_selectedIndex],
        floatingButton: null,
        customAppBar: null,
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
