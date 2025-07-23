import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sotaynamduoc/screen/auth/signin_screen.dart';
import 'package:sotaynamduoc/screen/components/form_input_field_with_icon.dart';
import 'package:sotaynamduoc/screen/components/form_vertical_spacing.dart';
import 'package:sotaynamduoc/screen/components/label_button.dart';
import 'package:sotaynamduoc/screen/components/logo_graphic_header.dart';
import 'package:sotaynamduoc/screen/components/primary_button.dart';
import 'package:sotaynamduoc/controllers/auth_controller.dart';
import 'package:sotaynamduoc/helpers/validator.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/background.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: _formKey,
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
                      controller: authController.emailController,
                      iconPrefix: Icons.email,
                      labelText: 'auth.emailFormField'.tr,
                      validator: Validator().email,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {},
                      onSaved: (value) =>
                          authController.emailController.text = value as String,
                    ),
                    FormVerticalSpace(),
                    PrimaryButton(
                        labelText: 'auth.resetPasswordButton'.tr,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await authController.sendPasswordResetEmail(context);
                          }
                        }),
                    FormVerticalSpace(),
                    signInLink(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  appBar(BuildContext context) {
    if (authController.emailController.text == '') {
      return null;
    }
    return AppBar(title: Text('auth.resetPasswordTitle'.tr));
  }

  signInLink(BuildContext context) {
    if (authController.emailController.text == '') {
      return LabelButton(
        labelText: 'auth.signInonResetPasswordLabelButton'.tr,
          onPressed: () => Get.offAll(SignInScreen()),
      );
    }
    return SizedBox(width: 0, height: 0);
  }
}
