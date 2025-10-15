import 'package:flutter/material.dart';
import 'package:scale_size/scale_size.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/domain/network/api_constant.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/colors.dart';
import 'package:sotaynamduoc/res/dimens.dart';
import 'package:sotaynamduoc/ui/widget/custom_text_label.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';

class AuthorDetailScreen extends StatelessWidget {
  final AuthorModel author;

  const AuthorDetailScreen({super.key, required this.author});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          author.name ?? 'Thầy thuốc',
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.secondaryBrand,
        foregroundColor: AppColors.white,

        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimens.SIZE_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: AppDimens.SIZE_24),
            _buildBasicInfo(),
            const SizedBox(height: AppDimens.SIZE_24),
            _buildBiography(),
            const SizedBox(height: AppDimens.SIZE_24),
            _buildCareer(),
            const SizedBox(height: AppDimens.SIZE_24),
            _buildAchievements(),
            const SizedBox(height: AppDimens.SIZE_24),
            _buildContributions(),
            const SizedBox(height: AppDimens.SIZE_24),
            _buildWorks(),
            const SizedBox(height: AppDimens.SIZE_24),
            _buildPhilosophy(),
            const SizedBox(height: AppDimens.SIZE_24),
            _buildLegacy(),
            const SizedBox(height: AppDimens.SIZE_24),
            _buildQuotes(),
            const SizedBox(height: AppDimens.SIZE_24),
            _buildAnecdotes(),
            const SizedBox(height: AppDimens.SIZE_24),
            _buildHonors(),
            const SizedBox(height: AppDimens.SIZE_24),
            _buildMemorials(),
            const SizedBox(height: AppDimens.SIZE_24),
            _buildReferences(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppDimens.SIZE_12),
          child: Container(
            width: 120.sw,
            height: 80.sh,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppDimens.SIZE_12),
              border: Border.all(
                color: AppColors.textHintGrey.withValues(alpha: 0.2),
              ),
            ),
            child: author.avatar != null || author.portrait != null
                ? BaseNetworkImage(
                    width: 120.sw,
                    height: 90.sh,
                    url:
                        ApiConstant.apiHost +
                        (author.avatar ?? author.portrait!),
                    fit: BoxFit.cover,
                  )
                : Icon(Icons.person, size: 60, color: AppColors.textMediumGrey),
          ),
        ),
        const SizedBox(width: AppDimens.SIZE_16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextLabel(
                author.name ?? AppLocalizations.current.noName,
                fontSize: AppDimens.SIZE_24,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
              if (author.alias != null) ...[
                const SizedBox(height: AppDimens.SIZE_8),
                CustomTextLabel(
                  '${AppLocalizations.current.alias}: ${author.alias}',
                  fontSize: AppDimens.SIZE_16,
                  color: AppColors.textMediumGrey,
                ),
              ],
              const SizedBox(height: AppDimens.SIZE_16),
              Row(
                children: [
                  if (author.viewCount != null) ...[
                    Icon(
                      Icons.visibility,
                      size: AppDimens.SIZE_16,
                      color: AppColors.textMediumGrey,
                    ),
                    const SizedBox(width: AppDimens.SIZE_4),
                    Text(
                      '${author.viewCount ?? 0}',
                      style: TextStyle(color: AppColors.textMediumGrey),
                    ),
                    const SizedBox(width: AppDimens.SIZE_16),
                  ],
                  if (author.likeCount != null) ...[
                    Icon(
                      Icons.favorite,
                      size: AppDimens.SIZE_16,
                      color: AppColors.textMediumGrey,
                    ),
                    const SizedBox(width: AppDimens.SIZE_4),
                    Text(
                      '${author.likeCount ?? 0}',
                      style: TextStyle(color: AppColors.textMediumGrey),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBasicInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextLabel(
          AppLocalizations.current.basicInfo,
          fontSize: AppDimens.SIZE_20,
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
        ),
        const SizedBox(height: AppDimens.SIZE_16),
        _buildInfoRow(AppLocalizations.current.birthPlace, author.birthPlace),
        _buildInfoRow(AppLocalizations.current.deathPlace, author.deathPlace),
        _buildInfoRow(AppLocalizations.current.era, author.era),
        _buildInfoRow(AppLocalizations.current.dynasty, author.dynasty),
        _buildInfoRow(AppLocalizations.current.specialty, author.specialty),
        _buildInfoRow(AppLocalizations.current.teacher, author.teacher),
        _buildInfoRow(AppLocalizations.current.students, author.students),
      ],
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimens.SIZE_8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: CustomTextLabel(
              '$label:',
              fontSize: AppDimens.SIZE_14,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          Expanded(
            child: CustomTextLabel(
              value,
              fontSize: AppDimens.SIZE_14,
              color: AppColors.textMediumGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBiography() {
    if (author.biography == null || author.biography!.isEmpty) {
      return const SizedBox.shrink();
    }

    return _buildSection(AppLocalizations.current.biography, author.biography!);
  }

  Widget _buildCareer() {
    if (author.career == null || author.career!.isEmpty) {
      return const SizedBox.shrink();
    }

    return _buildSection(AppLocalizations.current.career, author.career!);
  }

  Widget _buildAchievements() {
    if (author.achievements == null || author.achievements!.isEmpty) {
      return const SizedBox.shrink();
    }

    return _buildSection(
      AppLocalizations.current.achievements,
      author.achievements!,
    );
  }

  Widget _buildContributions() {
    if (author.contributions == null || author.contributions!.isEmpty) {
      return const SizedBox.shrink();
    }

    return _buildSection(
      AppLocalizations.current.contributions,
      author.contributions!,
    );
  }

  Widget _buildWorks() {
    if (author.works == null || author.works!.isEmpty) {
      return const SizedBox.shrink();
    }

    return _buildSection(AppLocalizations.current.works, author.works!);
  }

  Widget _buildPhilosophy() {
    if (author.philosophy == null || author.philosophy!.isEmpty) {
      return const SizedBox.shrink();
    }

    return _buildSection(
      AppLocalizations.current.philosophy,
      author.philosophy!,
    );
  }

  Widget _buildLegacy() {
    if (author.legacy == null || author.legacy!.isEmpty) {
      return const SizedBox.shrink();
    }

    return _buildSection(AppLocalizations.current.legacy, author.legacy!);
  }

  Widget _buildQuotes() {
    if (author.quotes == null || author.quotes!.isEmpty) {
      return const SizedBox.shrink();
    }

    return _buildSection(AppLocalizations.current.quotes, author.quotes!);
  }

  Widget _buildAnecdotes() {
    if (author.anecdotes == null || author.anecdotes!.isEmpty) {
      return const SizedBox.shrink();
    }

    return _buildSection(AppLocalizations.current.anecdotes, author.anecdotes!);
  }

  Widget _buildHonors() {
    if (author.honors == null || author.honors!.isEmpty) {
      return const SizedBox.shrink();
    }

    return _buildSection(AppLocalizations.current.honors, author.honors!);
  }

  Widget _buildMemorials() {
    if (author.memorials == null || author.memorials!.isEmpty) {
      return const SizedBox.shrink();
    }

    return _buildSection(AppLocalizations.current.memorials, author.memorials!);
  }

  Widget _buildReferences() {
    if (author.references == null || author.references!.isEmpty) {
      return const SizedBox.shrink();
    }

    return _buildSection(
      AppLocalizations.current.references,
      author.references!,
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextLabel(
          title,
          fontSize: AppDimens.SIZE_18,
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
        ),
        const SizedBox(height: AppDimens.SIZE_12),
        CustomTextLabel(
          content,
          fontSize: AppDimens.SIZE_14,
          color: AppColors.textMediumGrey,
        ),
      ],
    );
  }
}
