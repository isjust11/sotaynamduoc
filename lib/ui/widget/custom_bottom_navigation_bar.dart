import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sotaynamduoc/gen/assets.gen.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/resources.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });
  final int currentIndex;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    const selectedColor = AppColors.secondaryBrand;
    const unselectedColor = AppColors.hintTextColor;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.lightBackgroundAlt, width: 1),
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: selectedColor,
        selectedIconTheme: IconThemeData(color: selectedColor),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Assets.icons.icHome,
              width: AppDimens.SIZE_24,
              height: AppDimens.SIZE_24,
            ),
            label: AppLocalizations.current.home,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Assets.icons.icNews,
              width: AppDimens.SIZE_24,
              height: AppDimens.SIZE_24,
            ),
            label: AppLocalizations.current.news,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Assets.icons.icBaithuoc,
              width: AppDimens.SIZE_24,
              height: AppDimens.SIZE_24,
            ),
            label: AppLocalizations.current.medicine,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Assets.icons.icLibrary,
              width: AppDimens.SIZE_24,
              height: AppDimens.SIZE_24,
            ),
            label: AppLocalizations.current.library,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Assets.icons.icSetting,
              width: 24,
              height: 24,
            ),
            label: AppLocalizations.current.settings,
          ),
        ],
        currentIndex: currentIndex,
        onTap: onTap,
      ),
    );
  }
}
