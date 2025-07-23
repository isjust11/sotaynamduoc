import 'package:flutter/material.dart';
import 'package:scale_size/scale_size.dart';

import '../../gen/i18n/generated_locales/l10n.dart';
import '../../res/colors.dart';
import 'custom_text_label.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;
  final Widget? customLeading;
  final List<Widget>? actions;
  final Widget? customTitle;
  final Color? backgroundColor;

  const BaseAppBar({
    super.key, 
    this.title, 
    this.showBackButton = true,
    this.customLeading,
    this.actions,
    this.backgroundColor,
    this.customTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _buildTitle(context),
      centerTitle: true,
      backgroundColor: backgroundColor ?? AppColors.secondaryBrand,
      elevation: 0,
      automaticallyImplyLeading: false,
      leadingWidth: 74.sw,
      leading: _buildLeading(context),
      actions: actions,
    );
  }

  Widget? _buildTitle(BuildContext context) {
    if (customTitle != null) {
      return customTitle;
    }
    return CustomTextLabel(title,
          color: AppColors.white, fontSize: 15.sw, fontWeight: FontWeight.w700);
  }

  Widget? _buildLeading(BuildContext context) {
    if (customLeading != null) {
      return customLeading;
    }
    
    if (showBackButton) {
      return Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.only(bottom: 10.sw),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: CustomTextLabel(AppLocalizations.current.back,
              color: AppColors.white, fontSize: 13.sw, fontWeight: FontWeight.w400),
        ),
      );
    }
    
    return null;
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class ShareButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const ShareButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      // color: Colors.green,
      padding: EdgeInsets.only(bottom: 10.sw, right: 16.sw),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: CustomTextLabel(AppLocalizations.current.share,
            color: AppColors.white, fontSize: 13.sw, fontWeight: FontWeight.w400),
      ),
    );
  }
}