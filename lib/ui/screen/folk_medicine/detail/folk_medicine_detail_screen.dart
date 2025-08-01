import 'package:flutter/material.dart';
import 'package:sotaynamduoc/domain/data/models/folk_medicine_model.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/colors.dart';
import 'package:sotaynamduoc/ui/screen/screen.dart';
import 'package:sotaynamduoc/ui/widget/base_appbar.dart';
import 'package:sotaynamduoc/ui/widget/base_screen.dart';

class FolkMedicineDetailScreen extends StatelessWidget {
  final FolkMedicineModel folkMedicine;
  const FolkMedicineDetailScreen({super.key, required this.folkMedicine});


  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      colorBg: AppColors.white,
      onBackPress: () => Navigator.pop(context),
      customAppBar: BaseAppBar(
        title: AppLocalizations.current.featuredMedicine.toUpperCase(),
        showUndoIcon: true,
        showBackButton: true,
        backgroundColor: AppColors.secondaryBrand,
      ),
      body: FolkMedicineDetailBodyScreen(folkMedicine: folkMedicine),
    );
  }
}