import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:core';
import 'package:get/get.dart';
import 'package:sotaynamduoc/screen/components/form_input_field_with_icon.dart';
import 'package:sotaynamduoc/screen/components/form_vertical_spacing.dart';
import 'package:sotaynamduoc/screen/components/label_button.dart';
import 'package:sotaynamduoc/screen/components/logo_graphic_header.dart';
import 'package:sotaynamduoc/screen/components/primary_button.dart';
import 'package:sotaynamduoc/controllers/auth_controller.dart';
import 'package:sotaynamduoc/helpers/validator.dart';
import 'package:sotaynamduoc/screen/auth/signup_screen.dart';
import 'package:sotaynamduoc/screen/auth/reset_password_screen.dart';
import 'package:sotaynamduoc/gen/assets.gen.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.background.image().image,
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: _formKey,
          child: Container(
            
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      LogoGraphicHeader(),
                      SizedBox(height: 48.0),
                      FormInputFieldWithIcon(
                        controller: authController.usernameController,
                        iconPrefix: Icons.person,
                        labelText: 'auth.usernameFormField'.tr,
                        validator: Validator().username,
                        keyboardType: TextInputType.text,
                        onChanged: (value) => {},
                        onSaved: (value) =>
                            authController.usernameController.text = value!,
                      ),
                      FormVerticalSpace(),
                      FormInputFieldWithIcon(
                        controller: authController.passwordController,
                        iconPrefix: Icons.lock,
                        labelText: 'auth.passwordFormField'.tr,
                        validator: Validator().password,
                        obscureText: true,
                        onChanged: (value) => {},
                        onSaved: (value) =>
                            authController.passwordController.text = value!,
                        maxLines: 1,
                      ),
                      FormVerticalSpace(),
                      PrimaryButton(
                          labelText: 'auth.signInButton'.tr,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              authController.signInWithUsernameAndPassword(context);
                            }
                          }),
                      FormVerticalSpace(),
                      LabelButton(
                        labelText: 'auth.resetPasswordLabelButton'.tr,
                        onPressed: () => Get.to(ResetPasswordScreen()),
                      ),
                      LabelButton(
                        labelText: 'auth.signUpLabelButton'.tr,
                        onPressed: () => Get.to(SignUpScreen()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
