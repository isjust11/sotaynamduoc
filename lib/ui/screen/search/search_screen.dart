import 'package:flutter/material.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/colors.dart';
import 'package:sotaynamduoc/ui/screen/search/search_body_screen.dart';
import 'package:sotaynamduoc/ui/widget/base_appbar.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _isSearching = query.isNotEmpty;
    });
  }

  void _onSearchSubmitted() {
    if (_searchQuery.isNotEmpty) {
      // Thực hiện tìm kiếm
      setState(() {
        _isSearching = true;
      });
    }
  }

  void _onSearchCanceled() {
    setState(() {
      _searchQuery = '';
      _isSearching = false;
    });
    _searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: SearchBodyScreen(
        searchQuery: _searchQuery,
        isSearching: _isSearching,
      ),
      customAppBar: SearchAppBar(
        title: AppLocalizations.current.youCanSearch,
        showBackButton: true,
        backgroundColor: AppColors.secondaryBrand,
        searchController: _searchController,
        searchHint: 'Tìm kiếm thảo dược, bài thuốc...',
        onSearchChanged: _onSearchChanged,
        onSearchSubmitted: _onSearchSubmitted,
        onSearchCanceled: _onSearchCanceled,
      ),
    );
  }
}
