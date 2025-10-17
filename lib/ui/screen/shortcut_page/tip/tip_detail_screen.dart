import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scale_size/scale_size.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base_state.dart';
import 'package:sotaynamduoc/blocs/tip/tip_cubit.dart';
import 'package:sotaynamduoc/blocs/tip/tip_state.dart';
import 'package:sotaynamduoc/domain/data/models/tip_model.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/colors.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';

class TipDetailScreen extends StatefulWidget {
  final String tipId;

  const TipDetailScreen({super.key, required this.tipId});

  @override
  State<TipDetailScreen> createState() => _TipDetailScreenState();
}

class _TipDetailScreenState extends State<TipDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TipCubit>().getTipDetail(widget.tipId);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: BlocBuilder<TipCubit, BaseState>(
        builder: (context, state) {
          if (state is LoadingTipDetailState) {
            return _buildLoadingWidget();
          } else if (state is LoadedTipDetailState) {
            return _buildTipDetailContent(state.tip);
          } else if (state is ErrorTipDetailState) {
            return _buildErrorWidget(state.message);
          }
          return _buildEmptyWidget();
        },
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppColors.primaryBlue),
          SizedBox(height: 16.sw),
          CustomTextLabel(
            AppLocalizations.current.loading,
            fontSize: 14.sw,
            color: AppColors.textMediumGrey,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48.sw, color: AppColors.errorRed),
          SizedBox(height: 16.sw),
          CustomTextLabel(
            message,
            fontSize: 14.sw,
            color: AppColors.textDark,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.sw),
          ElevatedButton(
            onPressed: () {
              context.read<TipCubit>().getTipDetail(widget.tipId);
            },
            child: CustomTextLabel(
              AppLocalizations.current.retry,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lightbulb_outline,
            size: 48.sw,
            color: AppColors.textMediumGrey,
          ),
          SizedBox(height: 16.sw),
          CustomTextLabel(
            AppLocalizations.current.noTipsFound,
            fontSize: 16.sw,
            color: AppColors.textDark,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

  Widget _buildTipDetailContent(TipModel tip) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero image
          if (tip.thumbnail != null && tip.thumbnail!.isNotEmpty)
            _buildHeroImage(tip),

          // Content
          Padding(
            padding: EdgeInsets.all(16.sw),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                _buildTitle(tip),
                SizedBox(height: 12.sw),

                // Meta info
                _buildMetaInfo(tip),
                SizedBox(height: 16.sw),

                // Action buttons
                _buildActionButtons(tip),
                SizedBox(height: 24.sw),

                // Content
                _buildContent(tip),
                SizedBox(height: 24.sw),

                // Tags
                if (tip.tags != null && tip.tags!.isNotEmpty)
                  _buildTags(tip.tags!),

                SizedBox(height: 24.sw),

                // Related tips
                _buildRelatedTipsSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroImage(TipModel tip) {
    return Container(
      width: double.infinity,
      height: 250.sw,
      child: BaseNetworkImage(
        url: tip.thumbnail!,
        width: double.infinity,
        height: 250.sw,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildTitle(TipModel tip) {
    return CustomTextLabel(
      tip.title ?? '',
      fontSize: 24.sw,
      fontWeight: FontWeight.bold,
      color: AppColors.textDark,
      maxLines: 3,
    );
  }

  Widget _buildMetaInfo(TipModel tip) {
    return Row(
      children: [
        _buildMetaItem(
          Icons.schedule,
          tip.estimatedTime ?? '5 phút',
          AppColors.textMediumGrey,
        ),
        SizedBox(width: 16.sw),
        _buildMetaItem(
          Icons.trending_up,
          tip.difficulty ?? 'Dễ',
          _getDifficultyColor(tip.difficulty),
        ),
        SizedBox(width: 16.sw),
        _buildMetaItem(
          Icons.visibility,
          '${tip.viewCount ?? 0} lượt xem',
          AppColors.textMediumGrey,
        ),
        const Spacer(),
        _buildMetaItem(
          Icons.favorite,
          '${tip.likeCount ?? 0}',
          AppColors.errorRed,
        ),
      ],
    );
  }

  Widget _buildMetaItem(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 16.sw, color: color),
        SizedBox(width: 4.sw),
        CustomTextLabel(text, fontSize: 12.sw, color: color),
      ],
    );
  }

  Widget _buildActionButtons(TipModel tip) {
    return Row(
      children: [
        // Like button
        Expanded(
          child: _buildActionButton(
            icon: tip.isLiked == true ? Icons.favorite : Icons.favorite_border,
            label: tip.isLiked == true ? 'Đã thích' : 'Thích',
            color: tip.isLiked == true
                ? AppColors.errorRed
                : AppColors.textMediumGrey,
            onTap: () {
              if (tip.isLiked == true) {
                context.read<TipCubit>().unlikeTip(tip.id!);
              } else {
                context.read<TipCubit>().likeTip(tip.id!);
              }
            },
          ),
        ),
        SizedBox(width: 12.sw),
        // Bookmark button
        Expanded(
          child: _buildActionButton(
            icon: tip.isBookmarked == true
                ? Icons.bookmark
                : Icons.bookmark_border,
            label: tip.isBookmarked == true ? 'Đã lưu' : 'Lưu',
            color: tip.isBookmarked == true
                ? AppColors.primaryBlue
                : AppColors.textMediumGrey,
            onTap: () {
              if (tip.isBookmarked == true) {
                context.read<TipCubit>().unbookmarkTip(tip.id!);
              } else {
                context.read<TipCubit>().bookmarkTip(tip.id!);
              }
            },
          ),
        ),
        SizedBox(width: 12.sw),
        // Share button
        Expanded(
          child: _buildActionButton(
            icon: Icons.share,
            label: 'Chia sẻ',
            color: AppColors.textMediumGrey,
            onTap: () {
              context.read<TipCubit>().shareTip(tip.id!);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.sw, horizontal: 16.sw),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(8.sw),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18.sw, color: color),
            SizedBox(width: 8.sw),
            CustomTextLabel(
              label,
              fontSize: 12.sw,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(TipModel tip) {
    return Container(
      padding: EdgeInsets.all(16.sw),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.sw),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextLabel(
            'Nội dung',
            fontSize: 18.sw,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
          SizedBox(height: 12.sw),
          CustomTextLabel(
            tip.content ?? tip.summary ?? '',
            fontSize: 14.sw,
            color: AppColors.textDark,
          ),
        ],
      ),
    );
  }

  Widget _buildTags(List<String> tags) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextLabel(
          'Tags',
          fontSize: 16.sw,
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
        ),
        SizedBox(height: 8.sw),
        Wrap(
          spacing: 8.sw,
          runSpacing: 8.sw,
          children: tags.map((tag) => _buildTagChip(tag)).toList(),
        ),
      ],
    );
  }

  Widget _buildTagChip(String tag) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.sw, vertical: 6.sw),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.sw),
        border: Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.3)),
      ),
      child: CustomTextLabel(
        tag,
        fontSize: 12.sw,
        color: AppColors.primaryBlue,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildRelatedTipsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextLabel(
          'Mẹo liên quan',
          fontSize: 18.sw,
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
        ),
        SizedBox(height: 12.sw),
        BlocBuilder<TipCubit, BaseState>(
          builder: (context, state) {
            if (state is LoadingRelatedTipsState) {
              return _buildRelatedTipsLoading();
            } else if (state is LoadedRelatedTipsState) {
              return _buildRelatedTipsList(state.relatedTips);
            } else if (state is ErrorRelatedTipsState) {
              return _buildRelatedTipsError(state.message);
            }
            return _buildRelatedTipsEmpty();
          },
        ),
      ],
    );
  }

  Widget _buildRelatedTipsLoading() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.sw),
        child: CircularProgressIndicator(
          color: AppColors.primaryBlue,
          strokeWidth: 2,
        ),
      ),
    );
  }

  Widget _buildRelatedTipsList(List<TipModel> relatedTips) {
    if (relatedTips.isEmpty) {
      return _buildRelatedTipsEmpty();
    }

    return SizedBox(
      height: 200.sw,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: relatedTips.length,
        itemBuilder: (context, index) {
          final tip = relatedTips[index];
          return _buildRelatedTipCard(tip);
        },
      ),
    );
  }

  Widget _buildRelatedTipCard(TipModel tip) {
    return Container(
      width: 160.sw,
      margin: EdgeInsets.only(right: 12.sw),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.sw),
        border: Border.all(color: AppColors.border),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => TipDetailScreen(tipId: tip.id!),
            ),
          );
        },
        borderRadius: BorderRadius.circular(8.sw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            if (tip.thumbnail != null && tip.thumbnail!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.sw),
                  topRight: Radius.circular(8.sw),
                ),
                child: BaseNetworkImage(
                  url: tip.thumbnail!,
                  width: double.infinity,
                  height: 100.sw,
                  fit: BoxFit.cover,
                ),
              ),
            // Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.sw),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextLabel(
                      tip.title ?? '',
                      fontSize: 12.sw,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                      maxLines: 2,
                    ),
                    SizedBox(height: 4.sw),
                    CustomTextLabel(
                      tip.summary ?? '',
                      fontSize: 10.sw,
                      color: AppColors.textMediumGrey,
                      maxLines: 2,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 10.sw,
                          color: AppColors.textMediumGrey,
                        ),
                        SizedBox(width: 4.sw),
                        CustomTextLabel(
                          tip.estimatedTime ?? '5 phút',
                          fontSize: 10.sw,
                          color: AppColors.textMediumGrey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRelatedTipsError(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.sw),
        child: Column(
          children: [
            Icon(Icons.error_outline, size: 24.sw, color: AppColors.errorRed),
            SizedBox(height: 8.sw),
            CustomTextLabel(
              message,
              fontSize: 12.sw,
              color: AppColors.textMediumGrey,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRelatedTipsEmpty() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.sw),
        child: CustomTextLabel(
          'Không có mẹo liên quan',
          fontSize: 12.sw,
          color: AppColors.textMediumGrey,
        ),
      ),
    );
  }

  Color _getDifficultyColor(String? difficulty) {
    switch (difficulty?.toLowerCase()) {
      case 'easy':
      case 'dễ':
        return AppColors.successGreen;
      case 'medium':
      case 'trung bình':
        return AppColors.brandButtonVariant;
      case 'hard':
      case 'khó':
        return AppColors.errorRed;
      default:
        return AppColors.textMediumGrey;
    }
  }
}
