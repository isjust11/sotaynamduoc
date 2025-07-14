import 'package:flutter/material.dart';
import 'package:sotaynamduoc/controllers/auth_controller.dart';
import 'package:sotaynamduoc/ui/components/avatar.dart';
import 'package:sotaynamduoc/ui/components/form_vertical_spacing.dart';
import 'package:sotaynamduoc/ui/settings_ui.dart';
import 'package:get/get.dart';
import 'package:sotaynamduoc/ui/auth/update_profile_ui.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Tin tức'));
  }
}

class CayThuocScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Cây thuốc'));
  }
}

class HomeUI extends StatefulWidget {
  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    _HomeContent(),
    NewsScreen(),
    CayThuocScreen(),
    SettingsUI(), // Thay thế UpdateProfileUI bằng SettingsUI
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
              Get.to(() => SettingsUI());
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
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) => controller.currentUser.value?.id == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 120),
                  // Avatar(controller.currentUser.value!),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FormVerticalSpace(),
                      Text(
                          '${'home.idLabel'.tr}: ${controller.currentUser.value?.id ?? ''}',
                          style: TextStyle(fontSize: 16)),
                      FormVerticalSpace(),
                      Text(
                          '${'home.nameLabel'.tr}: ${controller.currentUser.value?.fullName ?? ''}',
                          style: TextStyle(fontSize: 16)),
                      FormVerticalSpace(),
                      Text(
                          '${'home.emailLabel'.tr}: ${controller.currentUser.value?.email ?? ''}',
                          style: TextStyle(fontSize: 16)),
                      FormVerticalSpace(),
                      Text(
                          '${'home.adminUserLabel'.tr}: ${controller.admin.value.toString()}',
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
