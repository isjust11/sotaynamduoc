import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scale_size/scale_size.dart';
import 'package:sotaynamduoc/domain/data/models/news_model.dart';
import 'package:sotaynamduoc/domain/network/api_constant.dart';
import 'package:sotaynamduoc/res/resources.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';
import 'package:sotaynamduoc/ui/widget/base_appbar.dart';
import 'package:sotaynamduoc/routes.dart';
import 'package:sotaynamduoc/blocs/news/news.dart';
import 'package:sotaynamduoc/injection_container.dart';
import 'news_detail_screen.dart';

class NewsListBlocScreen extends StatelessWidget {
  const NewsListBlocScreen({super.key});
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NewsBloc>()..add(const LoadNewsList()),
      child: const NewsListBlocView(),
    );
  }
}

class NewsListBlocView extends StatefulWidget {
  const NewsListBlocView({super.key});

  @override
  NewsListBlocViewState createState() => NewsListBlocViewState();
}

class NewsListBlocViewState extends State<NewsListBlocView> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final newsBloc = context.read<NewsBloc>();
      newsBloc.loadMore();
    }
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
      title: 'Tin Tức'.toUpperCase(),
      showUndoIcon: true,
      onBackTap: () => Navigator.pop(context),
      backgroundColor: AppColors.secondaryBrand,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        _buildSearchBar(),
        Expanded(
          child: BlocBuilder<NewsBloc, NewsState>(
            builder: (context, state) {
              if (state is NewsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is NewsListLoaded) {
                return _buildNewsList(state);
              } else if (state is NewsEmpty) {
                return _buildEmptyState(state.message);
              } else if (state is NewsError) {
                return _buildErrorState(state.message);
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.all(AppDimens.SIZE_16),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Tìm kiếm tin tức...',
          prefixIcon: Icon(Icons.search, color: AppColors.textMediumGrey),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: AppColors.textMediumGrey),
                  onPressed: () {
                    _searchController.clear();
                    context.read<NewsBloc>().add(
                      const LoadNewsList(isRefresh: true),
                    );
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimens.SIZE_8),
            borderSide: BorderSide(color: AppColors.secondaryBrand),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimens.SIZE_8),
            borderSide: BorderSide(color: AppColors.secondaryBrand, width: 2),
          ),
        ),
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            context.read<NewsBloc>().add(SearchNews(value));
          }
        },
      ),
    );
  }

  Widget _buildNewsList(NewsListLoaded state) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<NewsBloc>().add(const RefreshNews());
      },
      child: ListView.separated(
        controller: _scrollController,
        padding: EdgeInsets.all(AppDimens.SIZE_16),
        itemCount:
            state.newsList.length +
            (state.isLoadingMore ? 1 : 0) +
            (!state.hasMore && state.newsList.isNotEmpty ? 1 : 0),
        separatorBuilder: (context, index) {
          if (index >= state.newsList.length) {
            return const SizedBox.shrink();
          }
          return SizedBox(height: AppDimens.SIZE_12);
        },
        itemBuilder: (context, index) {
          if (index == state.newsList.length && state.isLoadingMore) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: AppDimens.SIZE_32),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          if (index == state.newsList.length &&
              !state.hasMore &&
              state.newsList.isNotEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: AppDimens.SIZE_24),
              child: Center(
                child: CustomTextLabel(
                  'Đã tải hết tin tức',
                  fontSize: AppDimens.SIZE_14,
                  color: AppColors.textDark,
                ),
              ),
            );
          }

          if (index < state.newsList.length) {
            return _buildNewsItem(context, state.newsList[index]);
          }

          return const SizedBox.shrink();
        },
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200.sh,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimens.SIZE_8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppDimens.SIZE_8),
                child: news.thumbnail != null
                    ? Image.network(
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
    );
  }

  Widget _buildEmptyState(String message) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<NewsBloc>().add(const RefreshNews());
      },
      child: ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.3),
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.article_outlined,
                  size: 64.sw,
                  color: AppColors.textDark.withValues(alpha: 0.3),
                ),
                SizedBox(height: AppDimens.SIZE_16),
                CustomTextLabel(
                  message,
                  fontSize: AppDimens.SIZE_16,
                  color: AppColors.textDark.withValues(alpha: 0.6),
                ),
                SizedBox(height: AppDimens.SIZE_8),
                CustomTextLabel(
                  'Kéo xuống để làm mới',
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

  Widget _buildErrorState(String message) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<NewsBloc>().add(const RefreshNews());
      },
      child: ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.3),
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64.sw,
                  color: AppColors.errorRed,
                ),
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
                    context.read<NewsBloc>().add(const RefreshNews());
                  },
                  child: const Text('Thử lại'),
                ),
              ],
            ),
          ),
        ],
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
