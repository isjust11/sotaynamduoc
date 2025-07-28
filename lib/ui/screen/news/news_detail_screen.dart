import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scale_size/scale_size.dart';
import 'package:sotaynamduoc/domain/data/models/news_model.dart';
import 'package:sotaynamduoc/res/resources.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';
import 'package:sotaynamduoc/ui/widget/base_appbar.dart';
import 'package:sotaynamduoc/blocs/news/news.dart';

class NewsDetailScreen extends StatelessWidget {
  final String newsId;
  final NewsBloc newsBloc;

  const NewsDetailScreen({
    super.key,
    required this.newsId,
    required this.newsBloc,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: newsBloc,
      child: NewsDetailView(newsId: newsId),
    );
  }
}

class NewsDetailView extends StatelessWidget  {
  final String newsId;
  const NewsDetailView({super.key, required this.newsId});

  @override
  Widget build(BuildContext context) {
    context.read<NewsBloc>().add(LoadNewsDetail(newsId));
    return BaseScreen(
      colorBg: AppColors.white,
      customAppBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  BaseAppBar _buildAppBar(BuildContext context) {
    return BaseAppBar(
      title: 'Chi Tiết Tin Tức'.toUpperCase(),
      showUndoIcon: true,
      onBackTap: () => Navigator.pop(context),
      backgroundColor: AppColors.secondaryBrand,
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is NewsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NewsDetailLoaded) {
          return _buildNewsDetail(state.news);
        } else if (state is NewsError) {
          return _buildErrorState(state.message);
        }
        return const SizedBox.shrink();
      },
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
                child: Image.network(
                  news.thumbnail!,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.lightGreyBackground,
                      child: Icon(
                        Icons.image_not_supported,
                        size: 60.sw,
                        color: AppColors.textMediumGrey,
                      ),
                    );
                  },
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
            CustomTextLabel(
              'Mô tả',
              fontSize: AppDimens.SIZE_16,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
            SizedBox(height: AppDimens.SIZE_8),
            CustomTextLabel(
              news.summary,
              fontSize: AppDimens.SIZE_14,
              color: AppColors.textDark,
            ),
            SizedBox(height: AppDimens.SIZE_16),
          ],

          // Nội dung
          CustomTextLabel(
            'Nội dung',
            fontSize: AppDimens.SIZE_16,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
          SizedBox(height: AppDimens.SIZE_8),
          CustomTextLabel(
            news.content,
            fontSize: AppDimens.SIZE_14,
            color: AppColors.textDark,
          ),

          SizedBox(height: AppDimens.SIZE_24),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64.sw, color: AppColors.errorRed),
          SizedBox(height: AppDimens.SIZE_16),
          CustomTextLabel(
            'Có lỗi xảy ra',
            fontSize: AppDimens.SIZE_16,
            color: AppColors.errorRed,
          ),
          SizedBox(height: AppDimens.SIZE_8),
          CustomTextLabel(
            message,
            fontSize: AppDimens.SIZE_14,
            color: AppColors.textDark.withValues(alpha: 0.6),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppDimens.SIZE_16),
          ElevatedButton(
            onPressed: () {
              // Có thể thêm logic retry ở đây
            },
            child: const Text('Thử lại'),
          ),
        ],
      ),
    );
  }
}
