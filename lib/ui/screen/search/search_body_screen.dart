import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/res/resources.dart';
import 'package:sotaynamduoc/ui/widget/custom_text_label.dart';
import 'package:sotaynamduoc/blocs/search/search.dart';

class SearchBodyScreen extends StatelessWidget {
  const SearchBodyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SearchSuggestionsLoaded) {
          return _buildSuggestionsView(context, state);
        } else if (state is SearchResultsLoaded) {
          return _buildSearchResultsView(context, state);
        } else if (state is SearchEmpty) {
          return _buildEmptyView(context, state);
        } else if (state is SearchError) {
          return _buildErrorView(context, state);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildSuggestionsView(
    BuildContext context,
    SearchSuggestionsLoaded state,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildSearchSuggestions(context, state.suggestions),
          _buildSearchHistory(context, state.searchHistory),
        ],
      ),
    );
  }

  Widget _buildSearchResultsView(
    BuildContext context,
    SearchResultsLoaded state,
  ) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(AppDimens.SIZE_16),
            itemCount: state.searchResults.length,
            itemBuilder: (context, index) {
              final result = state.searchResults[index];
              return _buildSearchResultItem(context, result);
            },
          ),
        ),
        if (state.hasMore)
          Padding(
            padding: EdgeInsets.all(AppDimens.SIZE_16),
            child: ElevatedButton(
              onPressed: state.isLoadingMore
                  ? null
                  : () => context.read<SearchBloc>().add(
                      const LoadMoreSearchResults(),
                    ),
              child: state.isLoadingMore
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Tải thêm'),
            ),
          ),
      ],
    );
  }

  Widget _buildEmptyView(BuildContext context, SearchEmpty state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: AppDimens.SIZE_48,
            color: AppColors.textMediumGrey,
          ),
          SizedBox(height: AppDimens.SIZE_16),
          CustomTextLabel(
            state.message,
            fontSize: AppDimens.SIZE_16,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
          SizedBox(height: AppDimens.SIZE_8),
          CustomTextLabel(
            'Thử tìm kiếm với từ khóa khác',
            fontSize: AppDimens.SIZE_14,
            color: AppColors.textMediumGrey,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, SearchError state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: AppDimens.SIZE_48,
            color: AppColors.errorRed,
          ),
          SizedBox(height: AppDimens.SIZE_16),
          CustomTextLabel(
            state.message,
            fontSize: AppDimens.SIZE_16,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
          SizedBox(height: AppDimens.SIZE_16),
          ElevatedButton(
            onPressed: () =>
                context.read<SearchBloc>().add(const RefreshSearch()),
            child: const Text('Thử lại'),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResultItem(
    BuildContext context,
    Map<String, dynamic> result,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: AppDimens.SIZE_12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimens.SIZE_8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(AppDimens.SIZE_16),
        leading: Container(
          width: AppDimens.SIZE_48,
          height: AppDimens.SIZE_48,
          decoration: BoxDecoration(
            color: AppColors.lightGreyBackground,
            borderRadius: BorderRadius.circular(AppDimens.SIZE_8),
          ),
          child: Icon(
            _getIconForType(result['type']),
            color: AppColors.primaryBrand,
            size: AppDimens.SIZE_24,
          ),
        ),
        title: CustomTextLabel(
          result['title'],
          fontSize: AppDimens.SIZE_14,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppDimens.SIZE_4),
            CustomTextLabel(
              result['description'],
              fontSize: AppDimens.SIZE_12,
              color: AppColors.textMediumGrey,
              maxLines: 2,
            ),
            SizedBox(height: AppDimens.SIZE_8),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimens.SIZE_8,
                    vertical: AppDimens.SIZE_4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBrand.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppDimens.SIZE_12),
                  ),
                  child: CustomTextLabel(
                    result['type'],
                    fontSize: AppDimens.SIZE_10,
                    color: AppColors.primaryBrand,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: AppDimens.SIZE_8),
                if (result['views'] != null)
                  Row(
                    children: [
                      Icon(
                        Icons.visibility,
                        size: AppDimens.SIZE_12,
                        color: AppColors.textMediumGrey,
                      ),
                      SizedBox(width: AppDimens.SIZE_4),
                      CustomTextLabel(
                        '${result['views']}',
                        fontSize: AppDimens.SIZE_10,
                        color: AppColors.textMediumGrey,
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
        onTap: () {
          context.read<SearchBloc>().add(SearchResultTapped(result));
          // TODO: Navigate to detail page
        },
      ),
    );
  }

  Widget _buildSearchSuggestions(
    BuildContext context,
    List<String> suggestions,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.SIZE_16,
        vertical: AppDimens.SIZE_8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextLabel(
            'Gợi ý tìm kiếm',
            fontSize: AppDimens.SIZE_14,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
          SizedBox(height: AppDimens.SIZE_8),
          Wrap(
            spacing: AppDimens.SIZE_8,
            runSpacing: AppDimens.SIZE_8,
            children: suggestions.map((suggestion) {
              return GestureDetector(
                onTap: () => context.read<SearchBloc>().add(
                  SearchSuggestionTapped(suggestion),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimens.SIZE_8,
                    vertical: AppDimens.SIZE_4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppDimens.SIZE_20),
                    border: Border.all(color: AppColors.border, width: 1),
                  ),
                  child: CustomTextLabel(
                    suggestion,
                    fontSize: AppDimens.SIZE_12,
                    color: AppColors.textMediumGrey,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchHistory(BuildContext context, List<String> searchHistory) {
    if (searchHistory.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(AppDimens.SIZE_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextLabel(
                'Lịch sử tìm kiếm',
                fontSize: AppDimens.SIZE_14,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
              GestureDetector(
                onTap: () =>
                    context.read<SearchBloc>().add(const ClearSearchHistory()),
                child: Row(
                  children: [
                    Icon(
                      Icons.close,
                      color: AppColors.errorRed,
                      size: AppDimens.SIZE_16,
                    ),
                    const SizedBox(width: AppDimens.SIZE_4),
                    CustomTextLabel(
                      'Xóa tất cả',
                      fontSize: AppDimens.SIZE_12,
                      color: AppColors.errorRed,
                    ),
                  ],
                ),
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: searchHistory.length,
            itemBuilder: (context, index) {
              final history = searchHistory[index];
              return ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.history,
                  color: AppColors.textMediumGrey,
                  size: AppDimens.SIZE_16,
                ),
                title: CustomTextLabel(
                  history,
                  fontSize: AppDimens.SIZE_14,
                  color: AppColors.textMediumGrey,
                  fontWeight: FontWeight.w500,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.gray,
                  size: AppDimens.SIZE_12,
                ),
                onTap: () => context.read<SearchBloc>().add(
                  SearchHistoryTapped(history),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  IconData _getIconForType(String type) {
    switch (type.toLowerCase()) {
      case 'thảo dược':
        return Icons.eco;
      case 'bài viết':
        return Icons.article;
      case 'bài thuốc':
        return Icons.medication;
      default:
        return Icons.search;
    }
  }
}
