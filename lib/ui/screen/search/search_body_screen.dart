import 'package:flutter/material.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/resources.dart';
import 'package:sotaynamduoc/ui/widget/custom_text_label.dart';

class SearchBodyScreen extends StatefulWidget {
  final String searchQuery;
  final bool isSearching;

  const SearchBodyScreen({
    super.key,
    required this.searchQuery,
    required this.isSearching,
  });

  @override
  State<SearchBodyScreen> createState() => _SearchBodyScreenState();
}

class _SearchBodyScreenState extends State<SearchBodyScreen> {
  List<String> _searchHistory = [];
  final List<String> _suggestions = [
    'Nhân sâm',
    'Nấm linh chi',
    'Đông trùng hạ thảo',
    'Hoàng kỳ',
    'Bạch truật',
    'Cam thảo',
    'Sinh địa',
    'Đương quy',
    'Bạch thược',
    'Xuyên khung',
  ];
  List<Map<String, dynamic>> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _loadSearchHistory();
  }

  @override
  void didUpdateWidget(SearchBodyScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.searchQuery != oldWidget.searchQuery &&
        widget.searchQuery.isNotEmpty) {
      _performSearch(widget.searchQuery);
    }
  }

  void _loadSearchHistory() {
    // TODO: Load from SharedPreferences or local storage
    _searchHistory = ['Nhân sâm', 'Nấm linh chi', 'Đông trùng hạ thảo'];
  }

  void _performSearch(String query) {
    if (query.isEmpty) return;

    setState(() {
      _searchResults = [
        {
          'title': 'Nhân sâm Hàn Quốc',
          'description':
              'Nhân sâm có tác dụng bồi bổ sức khỏe, tăng cường miễn dịch',
          'type': 'Thảo dược',
          'image': 'assets/images/placeholder.png',
        },
        {
          'title': 'Cách sử dụng nhân sâm',
          'description': 'Hướng dẫn chi tiết cách sử dụng nhân sâm hiệu quả',
          'type': 'Bài viết',
          'image': 'assets/images/placeholder.png',
        },
        {
          'title': 'Bài thuốc với nhân sâm',
          'description': 'Các bài thuốc Đông y sử dụng nhân sâm',
          'type': 'Bài thuốc',
          'image': 'assets/images/placeholder.png',
        },
      ];
    });

    // Add to search history
    if (!_searchHistory.contains(query)) {
      setState(() {
        _searchHistory.insert(0, query);
        if (_searchHistory.length > 10) {
          _searchHistory = _searchHistory.take(10).toList();
        }
      });
    }
  }

  void _onSuggestionTap(String suggestion) {
    _performSearch(suggestion);
  }

  void _onHistoryTap(String history) {
    _performSearch(history);
  }

  void _clearHistory() {
    setState(() {
      _searchHistory.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (widget.isSearching) ...[
            _buildSearchResults(),
          ] else ...[
            _buildSearchSuggestions(),
            _buildSearchHistory(),
          ],
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return Expanded(
        child: Center(
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
                AppLocalizations.current.noResultsFound,
                fontSize: AppDimens.SIZE_16,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
              SizedBox(height: AppDimens.SIZE_8),
              CustomTextLabel(
                AppLocalizations.current.trySearchingWithDifferentKeywords,
                fontSize: AppDimens.SIZE_14,
                color: AppColors.textMediumGrey,
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(AppDimens.SIZE_16),
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          final result = _searchResults[index];
          return _buildSearchResultItem(result);
        },
      ),
    );
  }

  Widget _buildSearchResultItem(Map<String, dynamic> result) {
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
            Icons.eco,
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
          ],
        ),
        onTap: () {
          // TODO: Navigate to detail page
        },
      ),
    );
  }

  Widget _buildSearchSuggestions() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.SIZE_16,
        vertical: AppDimens.SIZE_8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextLabel(
            AppLocalizations.current.searchSuggestions,
            fontSize: AppDimens.SIZE_14,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
          SizedBox(height: AppDimens.SIZE_8),
          Wrap(
            spacing: AppDimens.SIZE_8,
            runSpacing: AppDimens.SIZE_8,
            children: _suggestions.map((suggestion) {
              return GestureDetector(
                onTap: () => _onSuggestionTap(suggestion),
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

  Widget _buildSearchHistory() {
    if (_searchHistory.isEmpty) return SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(AppDimens.SIZE_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextLabel(
                AppLocalizations.current.searchHistory,
                fontSize: AppDimens.SIZE_14,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
              GestureDetector(
                onTap: _clearHistory,
                child: Row(
                  children: [
                    Icon(
                      Icons.close,
                      color: AppColors.errorRed,
                      size: AppDimens.SIZE_16,
                    ),
                    const SizedBox(width: AppDimens.SIZE_4),
                    CustomTextLabel(
                      AppLocalizations.current.clearAll,
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
            physics: NeverScrollableScrollPhysics(),
            itemCount: _searchHistory.length,
            itemBuilder: (context, index) {
              final history = _searchHistory[index];
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
                onTap: () => _onHistoryTap(history),
              );
            },
          ),
        ],
      ),
    );
  }
}
