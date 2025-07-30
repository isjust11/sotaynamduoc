import 'package:flutter/material.dart';
import 'package:scale_size/scale_size.dart';
import 'package:flutter_html/flutter_html.dart';
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
    return NewsDetailView(news: news);
  }
}

class NewsDetailView extends StatelessWidget  {
  final NewsModel news;
  const NewsDetailView({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      colorBg: AppColors.white,
      customAppBar: _buildAppBar(context),
      body: _buildNewsDetail(news),
    );
  }

  BaseAppBar _buildAppBar(BuildContext context) {
    return BaseAppBar(
      title: AppLocalizations.current.newsDetail.toUpperCase(),
      showUndoIcon: true,
      onBackTap: () => Navigator.pop(context),
      backgroundColor: AppColors.secondaryBrand,
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
                  ApiConstant.apiHost + (news.thumbnail ?? ''),
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
