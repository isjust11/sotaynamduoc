import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scale_size/scale_size.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/domain/data/models/news_model.dart';
import 'package:sotaynamduoc/gen/assets.gen.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/resources.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';
import 'package:sotaynamduoc/ui/widget/base_appbar.dart';
import 'package:sotaynamduoc/routes.dart';
import 'news_detail_screen.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  NewsListScreenState createState() => NewsListScreenState();
}

class NewsListScreenState extends State<NewsListScreen> {
  final ScrollController _scrollController = ScrollController();
  List<NewsModel> newsList = [];
  bool _isLoadingMore = false;
  bool _hasMore = true;
  bool _isInitialLoading = true;
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadNews();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore &&
        _hasMore) {
      _loadMore();
    }
  }

  Future<List<NewsModel>> _fetchNews(int page) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (page > 3) {
      return [];
    }

    return List.generate(10, (index) {
      final newsIndex = (page - 1) * 10 + index + 1;
      return NewsModel(
        id: 'news_$newsIndex',
        title: 'Tin tức số $newsIndex',
        content:
            'Sản phẩm sữa Hiup - Lô HU1245 đã bị thu hồi do không đạt tiêu chuẩn chất lượng. Vui lòng kiểm tra sản phẩm của bạn.',
        summary:
            'Theo quy định tại Thông tư số 10/2020/TT-BKHCN, các doanh nghiệp sử dụng mã số, mã vạch khi in mã vạch lên sản phẩm cần thực hiện việc kê khai thông tin sản phẩm trên Hệ thống quản lý mã số, mã vạch tại địa chỉ: Vnpc.gs1.gov.vn với 7 trường thông tin bắt buộc:\na) GTIN;\nb) Tên sản phẩm, nhãn hiệu;\nc) Mô tả sản phẩm;\nd) Nhóm sản phẩm (các loại sản phẩm có tính chất giống nhau);',
        createdAt: DateTime.now().subtract(Duration(hours: newsIndex)),
        thumbnail: 'https://i.postimg.cc/DwXCNJzw/info-image.png',
      );
    });
  }

  void _loadNews() async {
    final initialNews = await _fetchNews(_page);
    setState(() {
      newsList = initialNews;
      _hasMore = initialNews.isNotEmpty;
      _isInitialLoading = false;
    });
  }

  Future<void> _onRefresh() async {
    _page = 1;
    final newNews = await _fetchNews(_page);
    setState(() {
      newsList = newNews;
      _hasMore = newNews.isNotEmpty;
    });
  }

  Future<void> _loadMore() async {
    setState(() {
      _isLoadingMore = true;
    });

    _page++;
    final newNews = await _fetchNews(_page);

    setState(() {
      if (newNews.isEmpty) {
        _hasMore = false;
      } else {
        newsList.addAll(newNews);
      }
      _isLoadingMore = false;
    });
  }

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
      title: 'News List'.toUpperCase(),
      showUndoIcon: true,
      onBackTap: () => Navigator.pop(context),
      backgroundColor: AppColors.secondaryBrand,
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_isInitialLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (newsList.isEmpty) {
      return _buildEmptyState(context);
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.separated(
        controller: _scrollController,
        padding: EdgeInsets.all(AppDimens.SIZE_16),
        itemCount:
            newsList.length +
            (_isLoadingMore ? 1 : 0) +
            (!_hasMore && newsList.isNotEmpty ? 1 : 0),
        separatorBuilder: (context, index) {
          if (index >= newsList.length) {
            return const SizedBox.shrink();
          }
          return SizedBox(height: AppDimens.SIZE_12);
        },
        itemBuilder: (context, index) {
          if (index == newsList.length && _isLoadingMore) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: AppDimens.SIZE_32),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          if (index == newsList.length && !_hasMore && newsList.isNotEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: AppDimens.SIZE_24),
              child: Center(
                child: CustomTextLabel(
                  'All notifications loaded',
                  fontSize: AppDimens.SIZE_14,
                  color: AppColors.textDark,
                ),
              ),
            );
          }

          if (index < newsList.length) {
            return _buildNewsItem(context, newsList[index]);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.3),
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.notifications_none,
                  size: 64.sw,
                  color: AppColors.textDark.withValues(alpha: 0.3),
                ),
                SizedBox(height: AppDimens.SIZE_16),
                CustomTextLabel(
                  'No notifications yet',
                  fontSize: AppDimens.SIZE_16,
                  color: AppColors.textDark.withValues(alpha: 0.6),
                ),
                SizedBox(height: AppDimens.SIZE_8),
                CustomTextLabel(
                  'Pull to refresh',
                  fontSize: AppDimens.SIZE_14,
                  color: AppColors.textDark.withValues(alpha: 0.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsItem(BuildContext context, NewsModel news) {
    return InkWell(
      onTap: () => _navigateToDetail(context, news),
      borderRadius: BorderRadius.circular(AppDimens.SIZE_12),
      child: Container(
        padding: EdgeInsets.all(AppDimens.SIZE_16),
        decoration: BoxDecoration(
          color: AppColors.transparentOrangeOverlay.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(AppDimens.SIZE_12),
          border: Border.all(color: AppColors.secondaryBrand),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 200.sh,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppDimens.SIZE_8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppDimens.SIZE_8),
                        child: news.thumbnail != null
                            ? Image.network(
                                news.thumbnail ?? '',
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value:
                                              loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
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
                  SizedBox(height: AppDimens.SIZE_8),
                  CustomTextLabel(
                    news.title,
                    fontSize: AppDimens.SIZE_16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textDark,
                    maxLines: 2,
                  ),
                  SizedBox(height: AppDimens.SIZE_8),
                  CustomTextLabel(
                    news.timeString,
                    fontSize: AppDimens.SIZE_13,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textDark,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context, NewsModel news) {
    Navigator.pushNamed(
      context,
      Routes.newsDetailScreen,
      arguments: NewsDetailScreenArgs(news: news),
    );
  }
}
