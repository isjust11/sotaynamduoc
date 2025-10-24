import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scale_size/scale_size.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/domain/network/api_constant.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/colors.dart';
import 'package:sotaynamduoc/ui/widget/base_appbar.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';
import 'package:sotaynamduoc/blocs/discovery/discovery.dart';
import 'package:sotaynamduoc/routes.dart';

class QuickActionScreen extends StatefulWidget {
  final String actionType;
  final String title;

  const QuickActionScreen({
    super.key,
    required this.actionType,
    required this.title,
  });

  @override
  State<QuickActionScreen> createState() => _QuickActionScreenState();
}

class _QuickActionScreenState extends State<QuickActionScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  final int _pageSize = 10;
  bool _isLoadingMore = false;
  List<NewsModel> _items = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadInitialData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreData();
    }
  }

  void _loadInitialData() {
    context.read<DiscoveryBloc>().add(
      LoadQuickActionContent(widget.actionType, page: 1, pageSize: _pageSize),
    );
  }

  void _loadMoreData() {
    if (!_isLoadingMore) {
      setState(() {
        _isLoadingMore = true;
        _currentPage++;
      });

      context.read<DiscoveryBloc>().add(
        LoadQuickActionContent(
          widget.actionType,
          page: _currentPage,
          pageSize: _pageSize,
          isLoadMore: true,
        ),
      );
    }
  }

  void _refresh() {
    setState(() {
      _currentPage = 1;
      _items.clear();
      _isLoadingMore = false;
    });
    _loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: widget.title,
      customAppBar: _buildAppBar(context),
      body: BlocListener<DiscoveryBloc, DiscoveryState>(
        listener: (context, state) {
          if (state is QuickActionDataLoaded) {
            if (state.isLoadMore) {
              setState(() {
                _items.addAll(state.items);
                _isLoadingMore = false;
              });
            } else {
              setState(() {
                _items = state.items;
                _isLoadingMore = false;
              });
            }
          } else if (state is DiscoveryError) {
            setState(() {
              _isLoadingMore = false;
            });
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: BlocBuilder<DiscoveryBloc, DiscoveryState>(
          builder: (context, state) {
            if (state is DiscoveryLoading && _items.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (_items.isEmpty && state is! DiscoveryLoading) {
              return _buildEmptyState();
            }

            return RefreshIndicator(
              onRefresh: () async => _refresh(),
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.all(16.sw),
                itemCount: _items.length + (_isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _items.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  final item = _items[index];
                  return _buildItemCard(item);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  SearchAppBar _buildAppBar(BuildContext context) {
    return SearchAppBar(
      title: widget.title,
      showBackButton: true,
      backgroundColor: AppColors.secondaryBrand,
      onSearchChanged: (value) {
        if (value.isNotEmpty) {
          context.read<DiscoveryBloc>().add(SearchDiscovery(value));
        } else {
          _refresh();
        }
      },
      onSearchCanceled: () {
        _refresh();
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _getEmptyStateIcon(),
            size: 64.sw,
            color: AppColors.textMediumGrey,
          ),
          SizedBox(height: 16.sw),
          CustomTextLabel(
            _getEmptyStateMessage(),
            fontSize: 16.sw,
            color: AppColors.textDark,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.sw),
          CustomTextLabel(
            _getEmptyStateSubMessage(),
            fontSize: 14.sw,
            color: AppColors.textMediumGrey,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildItemCard(NewsModel item) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.sw),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.sw),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.newsDetailScreen,
            arguments: item,
          );
        },
        borderRadius: BorderRadius.circular(12.sw),
        child: Padding(
          padding: EdgeInsets.all(16.sw),
          child: Row(
            children: [
              // Thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(8.sw),
                child: Container(
                  width: 80.sw,
                  height: 80.sw,
                  color: AppColors.lightGreyBackground,
                  child: item.thumbnail != null && item.thumbnail!.isNotEmpty
                      ? BaseNetworkImage(
                          url: ApiConstant.storageHost + item.thumbnail!,
                          width: 80.sw,
                          height: 80.sw,
                          fit: BoxFit.cover,
                        )
                      : Icon(
                          _getItemIcon(),
                          size: 32.sw,
                          color: AppColors.textMediumGrey,
                        ),
                ),
              ),
              SizedBox(width: 12.sw),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextLabel(
                      item.title,
                      fontSize: 14.sw,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                      maxLines: 2,
                    ),
                    if (item.summary != null && item.summary!.isNotEmpty) ...[
                      SizedBox(height: 4.sw),
                      CustomTextLabel(
                        item.summary!,
                        fontSize: 12.sw,
                        color: AppColors.textMediumGrey,
                        maxLines: 2,
                      ),
                    ],
                    SizedBox(height: 8.sw),
                    Row(
                      children: [
                        Icon(
                          Icons.visibility,
                          size: 14.sw,
                          color: AppColors.textMediumGrey,
                        ),
                        SizedBox(width: 4.sw),
                        CustomTextLabel(
                          '${item.interactionStats?.viewCount ?? 0} ${AppLocalizations.current.views}',
                          fontSize: 12.sw,
                          color: AppColors.textMediumGrey,
                        ),
                        SizedBox(width: 16.sw),
                        Icon(
                          Icons.favorite,
                          size: 14.sw,
                          color: AppColors.textMediumGrey,
                        ),
                        SizedBox(width: 4.sw),
                        CustomTextLabel(
                          '${item.interactionStats?.likeCount ?? 0} ${AppLocalizations.current.likes}',
                          fontSize: 12.sw,
                          color: AppColors.textMediumGrey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getEmptyStateIcon() {
    switch (widget.actionType) {
      case 'trending':
        return Icons.trending_up;
      case 'favorites':
        return Icons.favorite_border;
      case 'recent':
        return Icons.history;
      case 'bookmarks':
        return Icons.bookmark_border;
      default:
        return Icons.inbox_outlined;
    }
  }

  String _getEmptyStateMessage() {
    switch (widget.actionType) {
      case 'trending':
        return AppLocalizations.current.noTrendingContent;
      case 'favorites':
        return AppLocalizations.current.noFavoritesContent;
      case 'recent':
        return AppLocalizations.current.noRecentContent;
      case 'bookmarks':
        return AppLocalizations.current.noBookmarksContent;
      default:
        return AppLocalizations.current.noDataAvailable;
    }
  }

  String _getEmptyStateSubMessage() {
    switch (widget.actionType) {
      case 'trending':
        return AppLocalizations.current.noTrendingContentSub;
      case 'favorites':
        return AppLocalizations.current.noFavoritesContentSub;
      case 'recent':
        return AppLocalizations.current.noRecentContentSub;
      case 'bookmarks':
        return AppLocalizations.current.noBookmarksContentSub;
      default:
        return AppLocalizations.current.tryAgain;
    }
  }

  IconData _getItemIcon() {
    switch (widget.actionType) {
      case 'trending':
        return Icons.trending_up;
      case 'favorites':
        return Icons.favorite;
      case 'recent':
        return Icons.history;
      case 'bookmarks':
        return Icons.bookmark;
      default:
        return Icons.article_outlined;
    }
  }
}
