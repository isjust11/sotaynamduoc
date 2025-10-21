import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scale_size/scale_size.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base_state.dart';
import 'package:sotaynamduoc/blocs/cubit.dart';
import 'package:sotaynamduoc/domain/data/enums/category_type.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/colors.dart';
import 'package:sotaynamduoc/res/dimens.dart';
import 'package:sotaynamduoc/routes.dart';
import 'package:sotaynamduoc/ui/widget/base_appbar.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';

class KnowledgeScreen extends StatefulWidget {
  const KnowledgeScreen({super.key});

  @override
  State<KnowledgeScreen> createState() => _KnowledgeScreenState();
}

class _KnowledgeScreenState extends State<KnowledgeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = '';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().getCategories(
      categoryTypeCode: CategoryType.Discovery.value,
    );
    context.read<NewsBloc>().add(
      LoadNewsList(
        page: 1,
        size: 10,
        categoryId: _selectedCategory.isNotEmpty ? _selectedCategory : null,
        articleCode: CategoryType.Discovery.value,
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: AppLocalizations.current.knowledge,
      customAppBar: _buildAppBar(context),
      body: Column(
        children: [
          _buildCategoryFilter(),
          Expanded(
            child: BlocBuilder<NewsBloc, NewsState>(
              buildWhen: (prev, curr) => curr is NewsListLoaded,
              builder: (context, state) {
                if (state is NewsListLoaded) {
                  final filteredItems = _getFilteredItems(state.newsList);
                  if (filteredItems.isEmpty) {
                    return _buildEmptyWidget();
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppDimens.SIZE_8,
                      horizontal: AppDimens.SIZE_8,
                    ),
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemCount: filteredItems.length,
                      separatorBuilder: (_, __) =>
                          SizedBox(width: AppDimens.SIZE_12),
                      itemBuilder: (context, idx) {
                        final item = filteredItems[idx];
                        return _buildKnowledgeCard(item);
                      },
                    ),
                  );
                } else if (state is NewsLoading) {
                  return const LoadingTemplate();
                } else if (state is NewsError) {
                  return const EmptyData();
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  SearchAppBar _buildAppBar(BuildContext context) {
    return SearchAppBar(
      title: AppLocalizations.current.knowledge,
      showBackButton: true,
      backgroundColor: AppColors.secondaryBrand,
      onSearchChanged: (value) {
        setState(() {
          _searchQuery = value;
        });
      },
      onSearchCanceled: () {
        setState(() {
          _searchQuery = '';
        });
      },
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.SIZE_8,
        vertical: AppDimens.SIZE_8,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: AppDimens.SIZE_8,
            offset: Offset(0, AppDimens.SIZE_2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: BlocBuilder<CategoryCubit, BaseState>(
          builder: (context, state) {
            if (state is LoadedState<List<CategoryModel>>) {
              final categories = state.data;

              return Row(
                children: categories.map((category) {
                  final isSelected = _selectedCategory == category.id;
                  return Container(
                    margin: EdgeInsets.only(right: AppDimens.SIZE_8),
                    child: FilterChip(
                      label: CustomTextLabel(
                        category.name,
                        fontSize: AppDimens.SIZE_12,
                        color: isSelected
                            ? AppColors.white
                            : AppColors.textDark,
                      ),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = (selected ? category.id : '')!;
                        });
                      },
                      backgroundColor: AppColors.lightGreyBackground,
                      selectedColor: AppColors.primaryBlue,
                      checkmarkColor: AppColors.white,
                    ),
                  );
                }).toList(),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  List<NewsModel> _getFilteredItems(List<NewsModel> items) {
    List<NewsModel> filteredItems = items;

    // Filter by category
    if (_selectedCategory.isNotEmpty &&
        _selectedCategory != AppLocalizations.current.all) {
      filteredItems = filteredItems
          .where((item) => item.categoryId == _selectedCategory)
          .toList();
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filteredItems = filteredItems
          .where(
            (item) =>
                item.title!.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ) ||
                item.summary!.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ) ||
                item.author!.name!.contains(_searchQuery.toLowerCase()),
          )
          .toList();
    }

    return filteredItems;
  }

  Widget _buildKnowledgeCard(NewsModel item) {
    return CardColItemWidget(
      onTap: () => _navigateToKnowledgeDetail(item),
      title: item.title ?? '',
      summary: item.summary ?? '',
      thumbnail: item.thumbnail ?? '',
      category: item.category?.name ?? '',
      views: item.interactionStats?.viewCount ?? 0,
      author: item.author?.name ?? '',
      isLiked: item.userInteractionStatus?['like'] ?? false,
      isBookmarked: item.userInteractionStatus?['bookmark'] ?? false,
      actionButtons: _buildActionButtons(
        isLiked: item.userInteractionStatus?['like'] ?? false,
        isBookmarked: item.userInteractionStatus?['bookmark'] ?? false,
        onShare: () {
          // Implement share functionality
        },
        onLiked: (isLiked) {
          setState(() {
            item.userInteractionStatus?['like'] = isLiked;
          });
        },
        onBookmarked: (isBookmarked) {
          setState(() {
            item.userInteractionStatus?['bookmark'] = isBookmarked;
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

  Widget _buildEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.school_outlined,
            size: 48.sw,
            color: AppColors.textMediumGrey,
          ),
          SizedBox(height: 16.sw),
          CustomTextLabel(
            AppLocalizations.current.noKnowledgeFound,
            fontSize: 14.sw,
            color: AppColors.textDark,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 8.sw),
          CustomTextLabel(
            AppLocalizations.current.trySearchingWithDifferentKeywords,
            fontSize: 12.sw,
            color: AppColors.textMediumGrey,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _navigateToKnowledgeDetail(NewsModel item) {
    Navigator.pushNamed(context, Routes.newsDetailScreen, arguments: item);
  }
}
