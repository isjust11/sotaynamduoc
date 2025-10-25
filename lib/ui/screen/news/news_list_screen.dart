import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scale_size/scale_size.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/domain/data/models/news_model.dart';
import 'package:sotaynamduoc/res/resources.dart';
import 'package:sotaynamduoc/ui/widget/base_appbar.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';
import 'package:sotaynamduoc/blocs/news/news.dart';
import 'package:sotaynamduoc/ui/screen/news/news_detail_screen.dart';
import 'package:sotaynamduoc/utils/shared_preference.dart';

enum CardViewType { row, column }

class NewsListScreen extends StatefulWidget {
  final bool isShowBackButton;
  const NewsListScreen({super.key, this.isShowBackButton = false});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen>
    with AutomaticKeepAliveClientMixin {
  Timer? _debounceTimer;
  CardViewType cardViewType = CardViewType.column;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadViewType();
  }

  void _loadViewType() {
    SharedPreferenceUtil.getCardViewType().then((value) {
      setState(() {
        cardViewType = value;
      });
    });
  }

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
      customAppBar: _buildAppBar(context),
      body: NewsListBlocView(viewType: cardViewType),
    );
  }

  SearchAppBar _buildAppBar(BuildContext context) {
    return SearchAppBar(
      title: AppLocalizations.current.news,
      showBackButton: widget.isShowBackButton,
      backgroundColor: AppColors.secondaryBrand,
      onSearchChanged: (value) {
        _debounceTimer?.cancel();
        _debounceTimer = Timer(const Duration(milliseconds: 1000), () {
          if (mounted) {
            context.read<NewsBloc>().add(SearchNews(value.trim()));
          }
        });
      },
      customLeading: widget.isShowBackButton
          ? null
          : IconButton(
              onPressed: () {
                setState(() {
                  cardViewType = cardViewType == CardViewType.row
                      ? CardViewType.column
                      : CardViewType.row;
                  SharedPreferenceUtil.saveCardViewType(cardViewType);
                });
              },
              icon: Icon(
                cardViewType == CardViewType.row
                    ? Icons.view_list
                    : Icons.view_column,
                color: AppColors.white,
                size: AppDimens.SIZE_24,
              ),
            ),
      onSearchCanceled: () {
        _debounceTimer?.cancel();
        context.read<NewsBloc>().add(const RefreshNews());
      },
    );
  }
}

class NewsListBlocView extends StatefulWidget {
  final CardViewType viewType;
  const NewsListBlocView({super.key, required this.viewType});

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
                return _buildNewsList(state, widget.viewType);
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNewsList(NewsListLoaded state, CardViewType viewType) {
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
            return _buildNewsItem(context, state.newsList[index], viewType);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildNewsItem(
    BuildContext context,
    NewsModel news,
    CardViewType viewType,
  ) {
    return viewType == CardViewType.row
        ? CardRowItemWidget(
            onTap: () => _navigateToDetail(context, news),
            title: news.title ?? '',
            thumbnail: news.thumbnail,
            createdAt: news.timeString,
            summary: news.summary,
          )
        : CardColItemWidget(
            onTap: () => _navigateToDetail(context, news),
            title: news.title ?? '',
            thumbnail: news.thumbnail,
            createdAt: news.timeString,
            summary: news.summary,
            category: news.category?.name ?? '',
            views: news.interactionStats?.viewCount ?? 0,
            author: news.author?.name ?? '',
            actionButtons: _buildActionButtons(
              isLiked: (news.interactionStats?.likeCount ?? 0) > 0,
              isBookmarked: (news.interactionStats?.bookmarkCount ?? 0) > 0,
              onShare: () {
                // Implement share functionality
              },
              onLiked: (isLiked) {
                setState(() {
                  news.interactionStats?.likeCount = isLiked ? 1 : 0;
                });
              },
              onBookmarked: (isBookmarked) {
                setState(() {
                  news.interactionStats?.bookmarkCount = isBookmarked ? 1 : 0;
                });
              },
            ),
          );
  }

  Widget _buildActionButtons({
    required Function(bool) onLiked,
    required Function(bool) onBookmarked,
    required bool isLiked,
    required bool isBookmarked,
    required Function() onShare,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Like button
        GestureDetector(
          onTap: () {
            onLiked(!isLiked);
          },
          child: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            size: 20.sw,
            color: isLiked ? AppColors.errorRed : AppColors.textMediumGrey,
          ),
        ),
        SizedBox(width: 12.sw),
        // Bookmark button
        GestureDetector(
          onTap: () {
            onBookmarked(!isBookmarked);
          },
          child: Icon(
            isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            size: 20.sw,
            color: isBookmarked
                ? AppColors.primaryBlue
                : AppColors.textMediumGrey,
          ),
        ),
        SizedBox(width: 12.sw),
        // Share button
        GestureDetector(
          onTap: () {
            onShare();
          },
          child: Icon(
            Icons.share,
            size: 20.sw,
            color: AppColors.textMediumGrey,
          ),
        ),
      ],
    );
  }

  void _navigateToDetail(BuildContext context, NewsModel news) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewsDetailScreen(news: news)),
    );
  }
}
