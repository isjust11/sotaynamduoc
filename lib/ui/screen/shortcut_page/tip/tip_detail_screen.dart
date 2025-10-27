import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:scale_size/scale_size.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base_state.dart';
import 'package:sotaynamduoc/blocs/base_bloc/interaction_state/user_interaction_state.dart';
import 'package:sotaynamduoc/blocs/tip/tip_bloc.dart';
import 'package:sotaynamduoc/blocs/tip/tip_event.dart';
import 'package:sotaynamduoc/blocs/tip/tip_state.dart';
import 'package:sotaynamduoc/blocs/user_interaction_cubit.dart';
import 'package:sotaynamduoc/domain/data/enums/interaction_target.dart';
import 'package:sotaynamduoc/domain/data/models/tip_model.dart';
import 'package:sotaynamduoc/domain/network/api_constant.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/colors.dart';
import 'package:sotaynamduoc/ui/widget/base_appbar.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';
import 'package:sotaynamduoc/utils/html_style_helper.dart';

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
    context.read<TipBloc>().add(LoadTipDetail(widget.tipId));
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      customAppBar: _buildAppBar(context),
      body: BlocBuilder<TipBloc, TipState>(
        builder: (context, state) {
          if (state is TipLoading) {
            return _buildLoadingWidget();
          } else if (state is TipDetailLoaded) {
            final tipData = (state).tip;
            return _buildTipDetailContent(tipData);
          } else if (state is TipError) {
            return _buildErrorWidget((state).message);
          } else if (state is TipEmpty) {
            return _buildEmptyWidget();
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  BaseAppBar _buildAppBar(BuildContext context) {
    return BaseAppBar(
      title: AppLocalizations.current.tipDetails,
      showBackButton: true,
      onBackTap: () => Navigator.pop(context),
      actions: [
        IconButton(
          icon: BlocBuilder<UserInteractionCubit, BaseState>(
            buildWhen: (prev, curr) => curr is LoadedUserInteractionState,
            builder: (context, state) {
              if (state is LoadedUserInteractionState) {
                final isLiked = context.read<UserInteractionCubit>().isLiked;
                return Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? AppColors.errorRed : AppColors.white,
                );
              }
              return Icon(Icons.favorite_border, color: AppColors.white);
            },
          ),
          onPressed: () {
            final id = widget.tipId;
            if (id.isEmpty) return;

            // Get current state to determine if liked

            final isLiked = context.read<UserInteractionCubit>().isLiked;

            if (!isLiked) {
              context.read<UserInteractionCubit>().like(
                targetType: InteractionTarget.article.value,
                targetId: id,
              );
            } else {
              context.read<UserInteractionCubit>().unlike(
                targetType: InteractionTarget.article.value,
                targetId: id,
              );
            }
          },
        ),
        IconButton(
          icon: BlocBuilder<UserInteractionCubit, BaseState>(
            buildWhen: (prev, curr) => curr is LoadedUserInteractionState,
            builder: (context, state) {
              if (state is LoadedUserInteractionState) {
                final isBookmarked = context
                    .read<UserInteractionCubit>()
                    .isBookmarked;
                return Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: isBookmarked ? AppColors.primaryBlue : AppColors.white,
                );
              }
              return Icon(
                Icons.bookmark_border,
                color: AppColors.textMediumGrey,
              );
            },
          ),
          onPressed: () {
            final id = widget.tipId;
            if (id.isEmpty) return;

            // Get current state to determine if liked

            final isBookmarked = context
                .read<UserInteractionCubit>()
                .isBookmarked;

            if (!isBookmarked) {
              context.read<UserInteractionCubit>().bookmark(
                targetType: InteractionTarget.article.value,
                targetId: id,
              );
            } else {
              context.read<UserInteractionCubit>().unbookmark(
                targetType: InteractionTarget.article.value,
                targetId: id,
              );
            }
          },
        ),
        IconButton(
          icon: Icon(Icons.share, color: AppColors.white),
          onPressed: () {
            final id = widget.tipId;
            if (id.isEmpty) return;
            context.read<UserInteractionCubit>().share(
              targetType: InteractionTarget.article.value,
              targetId: id,
            );
          },
        ),
      ],
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
              context.read<TipBloc>().add(LoadTipDetail(widget.tipId));
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
        url: ApiConstant.storageHost + (tip.thumbnail ?? ''),
        width: double.infinity,
        height: 250.sw,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildTitle(TipModel tip) {
    return CustomTextLabel(
      tip.title ?? '',
      fontSize: 16.sw,
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

  Widget _buildContent(TipModel tip) {
    return Html(
      data: tip.content ?? '',
      style: HtmlStyleHelper.getNewsContentStyle(),
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
        BlocBuilder<TipBloc, TipState>(
          builder: (context, state) {
            if (state is TipListLoaded) {
              return _buildRelatedTipsList(state.tipList);
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget _buildRelatedTipsList(List<TipModel> relatedTips) {
    if (relatedTips.isEmpty) {
      return const SizedBox.shrink();
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
