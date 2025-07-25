import 'package:flutter/material.dart';
import 'package:scale_size/scale_size.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/domain/data/models/news_model.dart';
import 'package:sotaynamduoc/res/resources.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';
import 'package:sotaynamduoc/ui/widget/base_appbar.dart';

class NewsDetailScreen extends StatefulWidget {
  final NewsModel news;

  const NewsDetailScreen({
    super.key,
    required this.news,
  });

  @override
  NewsDetailScreenState createState() => NewsDetailScreenState();
}

class NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      colorBg: AppColors.white,
      customAppBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  BaseAppBar _buildAppBar(BuildContext context) {
    return BaseAppBar(
      title: 'News Detail'.toUpperCase(),
      showUndoIcon: true,
      onBackTap: () => Navigator.pop(context),
      backgroundColor: AppColors.secondaryBrand,
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppDimens.SIZE_20),
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppDimens.SIZE_16),
      decoration: BoxDecoration(
        color: AppColors.primaryBrand.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(AppDimens.SIZE_12),
        border: Border.all(
          color: AppColors.secondaryBrand,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppDimens.SIZE_16),
          // Image illustration
          Center(
            child: Container(
              height: 200.sh,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimens.SIZE_8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppDimens.SIZE_8),
                child: widget.news.imageUrl != null
                    ? Image.network(
                        widget.news.imageUrl!,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
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
                      )
                    : Container(
                        color: AppColors.lightGreyBackground,
                        child: Icon(
                          Icons.image_not_supported,
                          size: 60,
                          color: AppColors.textMediumGrey,
                        ),
                      ),
              ),
            ),
          ),
           SizedBox(height: AppDimens.SIZE_16),
          // Date
          CustomTextLabel(
            widget.news.title,
            fontSize: AppDimens.SIZE_16,
            fontWeight: FontWeight.w700,
            color: AppColors.statusBarDark,
            maxLines: 1,
          ),
          SizedBox(height: AppDimens.SIZE_8),
          // Date
          Padding(
            padding: EdgeInsets.only(bottom: AppDimens.SIZE_12),
            child: CustomTextLabel(
              widget.news.formattedDate,
              fontSize: AppDimens.SIZE_12,
              fontWeight: FontWeight.w400,
              color: AppColors.textMediumGrey,
              maxLines: 1,
            ),
          ),
          // Content
          CustomTextLabel(
            widget.news.content,
            fontSize: AppDimens.SIZE_13,
            fontWeight: FontWeight.w400,
            color: AppColors.textDark,
            maxLines: 10,
          ),
          SizedBox(height: AppDimens.SIZE_16),
          // Content description
          CustomTextLabel(
            widget.news.description,
            fontSize: AppDimens.SIZE_13,
            fontWeight: FontWeight.w400,
            color: AppColors.textDark,
            textAlign: TextAlign.justify,
            maxLines: 20,
          ),
        ],
      ),
    );
  }
}

class NewsDetailScreenArgs {
  final NewsModel news;

  const NewsDetailScreenArgs({required this.news});
} 