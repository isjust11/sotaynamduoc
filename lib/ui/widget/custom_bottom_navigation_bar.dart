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
              color: currentIndex == 0 ? selectedColor : unselectedColor,
            ),
            label: AppLocalizations.current.home,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Assets.icons.icHistory,
              width: AppDimens.SIZE_24,
              height: AppDimens.SIZE_24,
              color: currentIndex == 1 ? selectedColor : unselectedColor,
            ),
            label: AppLocalizations.current.history,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Assets.icons.icHistory,
              width: AppDimens.SIZE_24,
              height: AppDimens.SIZE_24,
              color: currentIndex == 1 ? selectedColor : unselectedColor,
            ),
            label: AppLocalizations.current.news,
          ),
          // BottomNavigationBarItem(
          //   icon: SizedBox(
          //     width: AppDimens.SIZE_40, // Giới hạn lại kích thước cho hợp lý
          //     height: AppDimens.SIZE_40,
          //     child: Container(
          //       decoration: BoxDecoration(
          //         color: selectedColor,
          //         borderRadius: BorderRadius.circular(10),
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.black26,
          //             blurRadius: 8,
          //             offset: Offset(0, 2),
          //           ),
          //         ],
          //       ),
          //       child: Center(
          //         child: SvgPicture.asset(
          //           Assets.icons.icQrcode,
          //           width: AppDimens.SIZE_28, // Giảm kích thước icon
          //           height: AppDimens.SIZE_28,
          //         ),
          //       ),
          //     ),
          //   ),
          //   label: '',
          // ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Assets.icons.icComplant,
              width: AppDimens.SIZE_24,
              height: AppDimens.SIZE_24,
              color: currentIndex == 3 ? selectedColor : unselectedColor,
            ),
            label: AppLocalizations.current.complaint,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Assets.icons.icSetting,
              width: 24,
              height: 24,
              color: currentIndex == 4 ? selectedColor : unselectedColor,
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
