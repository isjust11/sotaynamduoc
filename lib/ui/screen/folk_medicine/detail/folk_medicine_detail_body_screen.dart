import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scale_size/scale_size.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base.dart';
import 'package:sotaynamduoc/blocs/cubit.dart';
import 'package:sotaynamduoc/domain/data/enums/enums.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/domain/network/api_constant.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/colors.dart';
import 'package:sotaynamduoc/res/dimens.dart';
import 'package:sotaynamduoc/ui/widget/base_appbar.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';
import 'package:sotaynamduoc/utils/common.dart';
import 'package:sotaynamduoc/utils/html_style_helper.dart';

class FolkMedicineDetailBodyScreen extends StatelessWidget {
  final FolkMedicineModel folkMedicine;
  const FolkMedicineDetailBodyScreen({super.key, required this.folkMedicine});

  @override
  Widget build(BuildContext context) {
    context.read<UserInteractionCubit>().resetState();
    return BaseScreen(
      interactionTarget: InteractionTarget.folkMedicine,
      interactionId: folkMedicine.id,
      customAppBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return BaseAppBar(
      title: folkMedicine.title ?? AppLocalizations.current.noName,
      showBackButton: true,
      onBackTap: () {
        Navigator.pop(context);
      },
      actions: [
        IconButton(
          icon: BlocBuilder<UserInteractionCubit, BaseState>(
            buildWhen: (prev, curr) => curr is LoadedUserInteractionState,
            builder: (context, state) {
              if (state is LoadedUserInteractionState) {
                final isLiked = context.read<UserInteractionCubit>().isLiked;
                return Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: AppColors.white,
                );
              }
              return Icon(Icons.favorite_border, color: AppColors.white);
            },
          ),
          onPressed: () {
            final id = folkMedicine.id ?? '';
            if (id.isEmpty) return;

            // Get current state to determine if liked

            final isLiked = context.read<UserInteractionCubit>().isLiked;

            if (!isLiked) {
              context.read<UserInteractionCubit>().like(
                targetType: InteractionTarget.folkMedicine.value,
                targetId: id,
              );
            } else {
              context.read<UserInteractionCubit>().unlike(
                targetType: InteractionTarget.folkMedicine.value,
                targetId: id,
              );
            }
          },
        ),
        IconButton(
          icon: Icon(Icons.share, color: AppColors.white),
          onPressed: () {
            final id = folkMedicine.id ?? '';
            if (id.isEmpty) return;
            context.read<UserInteractionCubit>().share(
              targetType: InteractionTarget.author.value,
              targetId: id,
            );
          },
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildImageSection(), _buildContentSection(context)],
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

  Widget _buildContentSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.sw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleSection(),
          const SizedBox(height: AppDimens.SIZE_4),
          _buildStatsSection(context),
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

  Widget _buildStatsSection(BuildContext context) {
    return BlocBuilder<UserInteractionCubit, BaseState>(
      buildWhen: (prev, curr) => curr is LoadedInteractionStatsState,
      builder: (context, state) {
        if (state is LoadedInteractionStatsState) {
          final InteractionStatsModel interactionStats = state.data;
          final int viewCount = interactionStats.viewCount ?? 0;
          final int likeCount = interactionStats.likeCount ?? 0;
          final String? createdAt = interactionStats.createdAt;
          return Row(
            children: [
              _buildStatItem(
                Icons.visibility,
                AppColors.yellowMaterial,
                '${AppLocalizations.current.viewCount} $viewCount',
              ),
              const SizedBox(width: AppDimens.SIZE_8),
              _buildStatItem(
                Icons.favorite,
                AppColors.primaryBlue,
                '${AppLocalizations.current.likeCount} $likeCount',
              ),
              if (createdAt != null && createdAt.isNotEmpty) ...[
                const SizedBox(width: AppDimens.SIZE_8),
                _buildStatItem(
                  Icons.calendar_today,
                  AppColors.textSubtleGrey,
                  createdAt,
                  isDate: true,
                ),
              ],
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildStatItem(
    IconData icon,
    Color iconColor,
    String text, {
    bool isDate = false,
  }) {
    return Row(
      children: [
        Icon(icon, size: 14.sw, color: iconColor),
        const SizedBox(width: AppDimens.SIZE_4),
        CustomTextLabel(
          isDate ? Common.formatDate(text, format: 'dd/MM/yyyy HH:mm') : text,
          fontSize: 12.sw,
          color: AppColors.textDark,
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
