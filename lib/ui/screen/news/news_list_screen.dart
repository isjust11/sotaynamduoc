import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scale_size/scale_size.dart';
import 'package:sotaynamduoc/gen/assets.gen.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/domain/data/models/news_model.dart';
import 'package:sotaynamduoc/domain/network/api_constant.dart';
import 'package:sotaynamduoc/res/resources.dart';
import 'package:sotaynamduoc/ui/widget/base_appbar.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';
import 'package:sotaynamduoc/blocs/news/news.dart';
import 'package:sotaynamduoc/ui/screen/news/news_detail_screen.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen>
    with AutomaticKeepAliveClientMixin {
  Timer? _debounceTimer;

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BaseScreen(
      stateWidget: CustomBlocResult<NewsBloc, NewsState>(
        loadingState: (state) => state is NewsLoading,
        errorState: (state) => state is NewsError,
        emptyState: (state) => state is NewsEmpty,
        loadingType: LoadingType.threeArchedCircle,
        showMessage: true,
        message: context.read<NewsBloc>().state is NewsLoading
            ? AppLocalizations.current.loading
            : context.read<NewsBloc>().state is NewsError
            ? (context.read<NewsBloc>().state as NewsError).message
            : context.read<NewsBloc>().state is NewsEmpty
            ? AppLocalizations.current.empty
            : null,
        backgroundColor: Colors.black.withValues(alpha: 0.4),
        indicatorColor: AppColors.baseColor,
        onRefresh: () => context.read<NewsBloc>().add(const RefreshNews()),
      ),
      colorBg: AppColors.white,
      title: AppLocalizations.current.news.toUpperCase(),
      customAppBar: _buildAppBar(context),
      body: const NewsListBlocView(),
    );
  }

  SearchAppBar _buildAppBar(BuildContext context) {
    return SearchAppBar(
      title: AppLocalizations.current.news.toUpperCase(),
      showBackButton: false,
      backgroundColor: AppColors.secondaryBrand,
      onSearchChanged: (value) {
        _debounceTimer?.cancel();
        _debounceTimer = Timer(const Duration(milliseconds: 1000), () {
          if (mounted) {
            context.read<NewsBloc>().add(SearchNews(value.trim()));
          }
        });
      },
      onSearchCanceled: () {
        _debounceTimer?.cancel();
        context.read<NewsBloc>().add(const RefreshNews());
      },
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
  bool _isDisposed = false;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final state = context.read<NewsBloc>().state;
      if (state is! NewsListLoaded) {
        context.read<NewsBloc>().add(const LoadNewsList());
      }
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isDisposed) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final newsBloc = context.read<NewsBloc>();
      if (!_isDisposed) {
        newsBloc.loadMore();
      }
    }
  }

  void _addBlocEvent(NewsEvent event) {
    if (!_isDisposed) {
      context.read<NewsBloc>().add(event);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // _buildSearchBar(),
        Expanded(
          child: BlocBuilder<NewsBloc, NewsState>(
            builder: (context, state) {
              if (state is NewsListLoaded) {
                return _buildNewsList(state);
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNewsList(NewsListLoaded state) {
    return RefreshIndicator(
      onRefresh: () async {
        _addBlocEvent(const RefreshNews());
      },
      child: ListView.separated(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(
          horizontal: AppDimens.SIZE_16,
          vertical: AppDimens.SIZE_4,
        ),
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
              padding: EdgeInsets.symmetric(vertical: AppDimens.SIZE_12),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          if (index == state.newsList.length &&
              !state.hasMore &&
              state.newsList.isNotEmpty &&
              state.newsList.length > 10) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: AppDimens.SIZE_24),
              child: Center(
                child: CustomTextLabel(
                  AppLocalizations.current.endOfList,
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
        padding: EdgeInsets.symmetric(
          horizontal: AppDimens.SIZE_16,
          vertical: AppDimens.SIZE_12,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppDimens.SIZE_6),
          border: Border.all(
            color: AppColors.textHintGrey.withValues(alpha: 0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.textDark.withValues(alpha: 0.1),
              blurRadius: AppDimens.SIZE_4,
              offset: Offset(AppDimens.SIZE_0, AppDimens.SIZE_2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppDimens.SIZE_8),
              child: news.thumbnail != null
                  ? Image.network(
                      height: 60.sh,
                      width: 100.sw,
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
                          color: AppColors.white,
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
            SizedBox(width: AppDimens.SIZE_8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextLabel(
                    news.title?.trim() ?? '',
                    fontSize: AppDimens.SIZE_14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                    maxLines: 2,
                  ),
                  SizedBox(height: AppDimens.SIZE_4),
                  news.summary != null && news.summary!.isNotEmpty
                      ? CustomTextLabel(
                          news.summary!.trim(),
                          fontSize: AppDimens.SIZE_12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textDark.withValues(alpha: 0.6),
                          maxLines: 2,
                        )
                      : const SizedBox.shrink(),
                  SizedBox(height: AppDimens.SIZE_8),
                  Row(
                    children: [
                      SvgPicture.asset(
                        Assets.icons.icTime,
                        width: AppDimens.SIZE_14,
                        height: AppDimens.SIZE_14,
                      ),
                      const SizedBox(width: AppDimens.SIZE_2),
                      CustomTextLabel(
                        news.timeString.trim(),
                        fontSize: AppDimens.SIZE_12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textDark.withValues(alpha: 0.6),
                        maxLines: 1,
                      ),
                    ],
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewsDetailScreen(news: news)),
    );
  }
}
