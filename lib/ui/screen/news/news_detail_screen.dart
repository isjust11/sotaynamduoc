import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scale_size/scale_size.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base.dart';
import 'package:sotaynamduoc/blocs/cubit.dart';
import 'package:sotaynamduoc/domain/data/enums/enums.dart';
import 'package:sotaynamduoc/domain/data/models/news_model.dart';
import 'package:sotaynamduoc/domain/network/api_constant.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/resources.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';
import 'package:sotaynamduoc/ui/widget/base_appbar.dart';
import 'package:sotaynamduoc/utils/html_style_helper.dart';

class NewsDetailScreen extends StatelessWidget {
  final NewsModel news;

  const NewsDetailScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    context.read<UserInteractionCubit>().resetState();
    return NewsDetailView(news: news);
  }
}

class NewsDetailView extends StatelessWidget {
  final NewsModel news;
  const NewsDetailView({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      interactionTarget: InteractionTarget.article,
      interactionId: news.id,
      customAppBar: _buildAppBar(context),
      body: _buildNewsDetail(news),
    );
  }

  BaseAppBar _buildAppBar(BuildContext context) {
    return BaseAppBar(
      title: AppLocalizations.current.newsDetail,
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
            final id = news.id ?? '';
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
          icon: Icon(Icons.share, color: AppColors.white),
          onPressed: () {
            final id = news.id ?? '';
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

  Widget _buildNewsDetail(NewsModel news) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppDimens.SIZE_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hình ảnh
          if (news.thumbnail != null)
            Container(
              height: 250.sh,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimens.SIZE_12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppDimens.SIZE_12),
                child: BaseNetworkImage(
                  url: ApiConstant.storageHost + (news.thumbnail ?? ''),
                  fit: BoxFit.cover,
                  showShimmer: false,
                ),
              ),
            ),

          SizedBox(height: AppDimens.SIZE_16),

          // Tiêu đề
          CustomTextLabel(
            news.title,
            fontSize: AppDimens.SIZE_20,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),

          SizedBox(height: AppDimens.SIZE_12),

          // Thời gian
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 16.sw,
                color: AppColors.textMediumGrey,
              ),
              SizedBox(width: AppDimens.SIZE_8),
              CustomTextLabel(
                '${news.formattedDate} - ${news.timeString}',
                fontSize: AppDimens.SIZE_14,
                color: AppColors.textMediumGrey,
              ),
            ],
          ),

          SizedBox(height: AppDimens.SIZE_16),

          // Mô tả
          if (news.summary != null && news.summary!.isNotEmpty) ...[
            SizedBox(height: AppDimens.SIZE_8),
            CustomTextLabel(
              news.summary,
              fontSize: AppDimens.SIZE_14,
              color: AppColors.textDark,
            ),
            SizedBox(height: AppDimens.SIZE_16),
          ],

          // Nội dung
          Html(
            data: news.content ?? '',
            style: HtmlStyleHelper.getNewsContentStyle(),
          ),
        ],
      ),
    );
  }
}
