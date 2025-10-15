import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scale_size/scale_size.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sotaynamduoc/blocs/folk_medicine/folk_medicine_bloc.dart';
import 'package:sotaynamduoc/blocs/folk_medicine/folk_medicine_event.dart';
import 'package:sotaynamduoc/domain/data/models/folk_medicine_model.dart';
import 'package:sotaynamduoc/domain/network/api_constant.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/colors.dart';
import 'package:sotaynamduoc/res/dimens.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';
import 'package:sotaynamduoc/utils/common.dart';
import 'package:sotaynamduoc/utils/html_style_helper.dart';

class FolkMedicineDetailBodyScreen extends StatelessWidget {
  final FolkMedicineModel folkMedicine;
  const FolkMedicineDetailBodyScreen({super.key, required this.folkMedicine});

  @override
  Widget build(BuildContext context) {
    context.read<FolkMedicineBloc>().add(
      UpdateFolkMedicineView(folkMedicine.id ?? ''),
    );
    return BaseScreen(
      hideAppBar: true,
      colorBg: AppColors.white,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildImageSection(), _buildContentSection()],
      ),
    );
  }

  Widget _buildImageSection() {
    return SizedBox(
      height: 250.sw,
      width: double.infinity,
      child: BaseNetworkImage(
        url: ApiConstant.storageHost + folkMedicine.thumbnail.toString(),
        width: double.infinity,
        height: 250.sw,
        borderRadius: 0,
      ),
    );
  }

  Widget _buildContentSection() {
    return Container(
      padding: EdgeInsets.all(16.sw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleSection(),
          const SizedBox(height: AppDimens.SIZE_4),
          _buildStatsSection(),
          const SizedBox(height: AppDimens.SIZE_8),
          _buildSummarySection(),
          const SizedBox(height: AppDimens.SIZE_4),
          _buildIngredientsSection(),
          const SizedBox(height: AppDimens.SIZE_4),
          _buildPreparationSection(),
          const SizedBox(height: AppDimens.SIZE_4),
          _buildUsageSection(),
          const SizedBox(height: AppDimens.SIZE_4),
          _buildNotesSection(),
          const SizedBox(height: AppDimens.SIZE_4),
          _buildHtmlContentSection(),
        ],
      ),
    );
  }

  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextLabel(
          folkMedicine.title ?? '',
          fontSize: 18.sw,
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
          maxLines: 3,
        ),
        if (folkMedicine.category?.name != null &&
            (folkMedicine.category!.name?.isNotEmpty ?? false))
          Padding(
            padding: const EdgeInsets.only(top: AppDimens.SIZE_8),
            child: Row(
              children: [
                Icon(
                  Icons.category,
                  size: 14.sw,
                  color: AppColors.textMediumGrey,
                ),
                SizedBox(width: AppDimens.SIZE_4),
                CustomTextLabel(
                  folkMedicine.category!.name!,
                  fontSize: 12.sw,
                  color: AppColors.textMediumGrey,
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildStatsSection() {
    final int viewCount = folkMedicine.viewCount ?? 0;
    final int likeCount = folkMedicine.likeCount ?? 0;
    final String? createdAt = folkMedicine.createdAt;

    return Row(
      children: [
        _buildStatItem(
          Icons.visibility,
          '${AppLocalizations.current.viewCount} $viewCount',
        ),
        const SizedBox(width: AppDimens.SIZE_8),
        _buildStatItem(
          Icons.favorite,
          '${AppLocalizations.current.likeCount} $likeCount',
        ),
        if (createdAt != null && createdAt.isNotEmpty) ...[
          const SizedBox(width: AppDimens.SIZE_8),
          _buildStatItem(Icons.calendar_today, createdAt, isDate: true),
        ],
      ],
    );
  }

  Widget _buildStatItem(IconData icon, String text, {bool isDate = false}) {
    return Row(
      children: [
        Icon(icon, size: 14.sw, color: AppColors.textMediumGrey),
        const SizedBox(width: AppDimens.SIZE_4),
        CustomTextLabel(
          isDate ? Common.formatDate(text, format: 'dd/MM/yyyy HH:mm') : text,
          fontSize: 12.sw,
          color: AppColors.textMediumGrey,
        ),
      ],
    );
  }

  Widget _buildSummarySection() {
    final String? summary = folkMedicine.summary;
    if (summary == null || summary.isEmpty) return const SizedBox.shrink();

    return _buildInfoCard(
      AppLocalizations.current.folkMedicineDescription,
      CustomTextLabel(summary, fontSize: 14.sw, color: AppColors.textDark),
      icon: Icons.description,
    );
  }

  Widget _buildIngredientsSection() {
    final String? ingredients = folkMedicine.ingredients;
    if (ingredients == null || ingredients.isEmpty) {
      return const SizedBox.shrink();
    }

    return _buildInfoCard(
      AppLocalizations.current.folkMedicineIngredients,
      CustomTextLabel(ingredients, fontSize: 14.sw, color: AppColors.textDark),
      icon: Icons.list_alt,
    );
  }

  Widget _buildPreparationSection() {
    final String? prep = folkMedicine.preparation;
    if (prep == null || prep.isEmpty) return const SizedBox.shrink();

    return _buildInfoCard(
      AppLocalizations.current.folkMedicinePreparation,
      CustomTextLabel(prep, fontSize: 14.sw, color: AppColors.textDark),
      icon: Icons.restaurant,
    );
  }

  Widget _buildUsageSection() {
    final String? usage = folkMedicine.usage;
    if (usage == null || usage.isEmpty) return const SizedBox.shrink();

    return _buildInfoCard(
      AppLocalizations.current.folkMedicineUsage,
      CustomTextLabel(usage, fontSize: 14.sw, color: AppColors.textDark),
      icon: Icons.medical_services,
    );
  }

  Widget _buildNotesSection() {
    final String? notes = folkMedicine.notes;
    if (notes == null || notes.isEmpty) return const SizedBox.shrink();

    return _buildInfoCard(
      AppLocalizations.current.folkMedicineNote,
      CustomTextLabel(notes, fontSize: 14.sw, color: AppColors.textDark),
      icon: Icons.sticky_note_2_outlined,
      isWarning: false,
    );
  }

  Widget _buildHtmlContentSection() {
    final String? html = folkMedicine.content;
    if (html == null || html.isEmpty) return const SizedBox.shrink();

    return _buildInfoCard(
      AppLocalizations.current.detail,
      Html(data: html, style: HtmlStyleHelper.getNewsContentStyle()),
      icon: Icons.article,
    );
  }

  Widget _buildInfoCard(
    String title,
    Widget content, {
    IconData? icon,
    bool isWarning = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: AppDimens.SIZE_4),
      padding: EdgeInsets.symmetric(horizontal: 16.sw, vertical: 8.sw),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(
          color: AppColors.textHintGrey.withValues(alpha: 0.2),
        ),
        borderRadius: BorderRadius.circular(AppDimens.SIZE_12),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: AppDimens.SIZE_8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 18.sw,
                  color: isWarning ? AppColors.errorRed : AppColors.border,
                ),
                SizedBox(width: 8.sw),
              ],
              Expanded(
                child: CustomTextLabel(
                  title,
                  fontSize: 14.sw,
                  fontWeight: FontWeight.bold,
                  color: isWarning ? AppColors.errorRed : AppColors.textDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.sw),
          content,
        ],
      ),
    );
  }
}
