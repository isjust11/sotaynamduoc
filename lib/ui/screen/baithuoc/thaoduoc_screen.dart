import 'package:flutter/material.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/colors.dart';
import 'package:sotaynamduoc/ui/widget/base_appbar.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';

class BaithuocScreen extends StatelessWidget {
  const BaithuocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      colorBg: AppColors.white,
      customAppBar: BaseAppBar(
        title: AppLocalizations.current.featuredMedicine.toUpperCase(),
        showUndoIcon: true,
        showBackButton: false,
        backgroundColor: AppColors.secondaryBrand,
      ),
      body: Center(child: Text('Bài thuốc')),
    );
  }
}
