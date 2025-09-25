import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sotaynamduoc/gen/assets.gen.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/resources.dart';
import 'package:sotaynamduoc/routes.dart';
import 'package:sotaynamduoc/ui/widget/custom_text_label.dart';
import 'package:sotaynamduoc/utils/shared_preference.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashState();
  }
}

class _SplashState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => openScreen(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.baseColor,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.images.welcome.path),
                  fit: BoxFit.cover,
                ),
              ) /* add child content here */,
            ),
            Positioned(
              top: -150,
              left: -50,
              child: Container(
                width: AppDimens.SIZE_480,
                height: AppDimens.SIZE_480,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.baseColor.withValues(alpha: 0.4),
                      AppColors.secondaryBrand.withValues(alpha: 0.2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(AppDimens.SIZE_240),
                ),
              ),
            ),

            Positioned(
              top: AppDimens.SIZE_120,
              left: AppDimens.SIZE_16,
              child: Column(
                children: [
                  CustomTextLabel(
                    AppLocalizations.current.welcomeTo,
                    fontSize: AppDimens.SIZE_24,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
            Positioned(
              top: AppDimens.SIZE_150,
              left: AppDimens.SIZE_26,
              child: Column(
                children: [
                  const SizedBox(height: AppDimens.SIZE_16),
                  CustomTextLabel(
                    AppLocalizations.current.appName,
                    fontSize: AppDimens.SIZE_36,
                    color: AppColors.baseColor,
                    fontWeight: FontWeight.w900,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  openScreen(BuildContext context) async {
    String token = await SharedPreferenceUtil.getAccessToken();
    await Future.delayed(Duration(seconds: 2));
    if (token.isEmpty) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.loginScreen,
        (route) => false,
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.mainScreen,
        (route) => false,
      );
    }
  }
}
