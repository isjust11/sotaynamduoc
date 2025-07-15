import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sotaynamduoc/controllers/auth_controller.dart';
import 'package:sotaynamduoc/screen/components/form_vertical_spacing.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

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
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}