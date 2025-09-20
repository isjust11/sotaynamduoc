import 'package:flutter/material.dart';
import 'package:scale_size/scale_size.dart';

import '../../gen/i18n/generated_locales/l10n.dart';
import '../../res/resources.dart';
import 'custom_text_label.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;
  final Widget? customLeading;
  final List<Widget>? actions;
  final Widget? customTitle;
  final Color? backgroundColor;
  final VoidCallback? onBackTap;
  final String? backButtonText;
  final bool showUndoIcon;
  final bool? centerTitle;

  const BaseAppBar({
    super.key,
    this.title,
    this.showBackButton = true,
    this.customLeading,
    this.actions,
    this.backgroundColor,
    this.customTitle,
    this.onBackTap,
    this.backButtonText,
    this.showUndoIcon = false,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _buildTitle(context),
      centerTitle: centerTitle,
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
    return CustomTextLabel(
      title,
      color: AppColors.white,
      fontSize: AppDimens.SIZE_14,
      fontWeight: FontWeight.w700,
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (customLeading != null) {
      return customLeading;
    }

    if (showBackButton) {
      return Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.only(bottom: AppDimens.SIZE_10),
        child: InkWell(
          onTap:
              onBackTap ??
              () {
                Navigator.pop(context);
              },
          child: showUndoIcon
              ? Icon(Icons.arrow_back_ios_new, color: AppColors.white)
              : CustomTextLabel(
                  backButtonText ?? AppLocalizations.current.back,
                  color: AppColors.white,
                  fontSize: AppDimens.SIZE_13,
                  fontWeight: FontWeight.w400,
                ),
        ),
      );
    }

    return null;
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class SearchAction extends StatelessWidget {
  final VoidCallback? onPressed;

  const SearchAction({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      // color: Colors.green,
      padding: EdgeInsets.only(
        bottom: AppDimens.SIZE_16,
        right: AppDimens.SIZE_16,
      ),
      child: InkWell(
        onTap: () {
          onPressed?.call();
        },
        child: Icon(Icons.search, color: AppColors.white),
      ),
    );
  }
}
