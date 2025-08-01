import 'package:flutter/material.dart';
import 'package:sotaynamduoc/domain/data/models/folk_medicine_model.dart';
import 'package:sotaynamduoc/domain/network/api_constant.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/colors.dart';
import 'package:sotaynamduoc/res/dimens.dart';
import 'package:sotaynamduoc/ui/widget/base_screen.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';

class FolkMedicineDetailBodyScreen extends StatelessWidget {
  final FolkMedicineModel folkMedicine;
  const FolkMedicineDetailBodyScreen({super.key, required this.folkMedicine});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      hideAppBar: true,
      colorBg: AppColors.white,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            ApiConstant.apiHost + (folkMedicine.thumbnail ?? ''),
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.SIZE_16,
              vertical: 8.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailItem(
                  AppLocalizations.current.folkMedicineName,
                  folkMedicine.title ?? '',
                ),
                _buildDetailItem(
                  AppLocalizations.current.folkMedicineDescription,
                  folkMedicine.summary ?? '',
                ),
                _buildDetailItem(
                  AppLocalizations.current.folkMedicineIngredients,
                  folkMedicine.ingredients ?? '',
                ),
                _buildDetailItem(
                  AppLocalizations.current.folkMedicinePreparation,
                  folkMedicine.preparation ?? '',
                ),
                _buildDetailItem(
                  AppLocalizations.current.folkMedicineUsage,
                  folkMedicine.usage ?? '',
                ),
                _buildDetailItem(
                  AppLocalizations.current.folkMedicineNote,
                  folkMedicine.notes ?? '',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.SIZE_8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextLabel(
            title,
            fontSize: AppDimens.SIZE_14,
            fontWeight: FontWeight.w500,
            color: AppColors.textDark,
          ),
          const SizedBox(height: AppDimens.SIZE_4),
          CustomTextLabel(
            value,
            fontSize: AppDimens.SIZE_12,
            fontWeight: FontWeight.w400,
            color: AppColors.textDark,
          ),
        ],
      ),
    );
  }
}
