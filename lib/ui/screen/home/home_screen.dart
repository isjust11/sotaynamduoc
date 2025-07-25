import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sotaynamduoc/gen/assets.gen.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/colors.dart';
import 'package:sotaynamduoc/res/dimens.dart';
import 'package:sotaynamduoc/ui/widget/base_appbar.dart';
import 'package:sotaynamduoc/ui/screen/home/home_body.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';
import 'package:sotaynamduoc/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  void _navigateToNotificationList(BuildContext context) {
    Navigator.pushNamed(context, Routes.newsListScreen);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      onBackPress: null,
      body: HomeBody(),
      floatingButton: null,
      bottomNavigationBar: null,
      hiddenIconBack: true,
      customAppBar: BaseAppBar(
        title: '',
        showBackButton: false,
        customTitle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: AppDimens.SIZE_20,
              backgroundColor: AppColors.inputBorderLight,
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.person),
              ),
            ),
            SizedBox(width: AppDimens.SIZE_10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextLabel(AppLocalizations.current.hello, color: AppColors.white, fontSize: AppDimens.SIZE_12, fontWeight: FontWeight.w400),
                SizedBox(height: AppDimens.SIZE_4),
                CustomTextLabel('Nguyễn Văn A', color: AppColors.white, fontSize: AppDimens.SIZE_16, fontWeight: FontWeight.w500),
              ],
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              _navigateToNotificationList(context);
            },
            icon: Icon(Icons.notifications),
          ),
        ],
      ),
    );
  }
}