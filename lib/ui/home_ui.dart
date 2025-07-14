import 'package:flutter/material.dart';
import 'package:sotaynamduoc/controllers/auth_controller.dart';
import 'package:sotaynamduoc/ui/components/avatar.dart';
import 'package:sotaynamduoc/ui/components/form_vertical_spacing.dart';
import 'package:sotaynamduoc/ui/settings_ui.dart';
import 'package:get/get.dart';

class HomeUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) => controller.currentUser.value?.id == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: AppBar(
                title: Text('home.title'.tr),
                actions: [
                  IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        Get.to(SettingsUI());
                      }),
                ],
              ),
              body: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 120),
                    Avatar(controller.currentUser.value!),
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
            ),
    );
  }
}
