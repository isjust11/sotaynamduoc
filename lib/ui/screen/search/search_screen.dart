import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/colors.dart';
import 'package:sotaynamduoc/ui/screen/search/search_body_screen.dart';
import 'package:sotaynamduoc/ui/widget/base_appbar.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';
import 'package:sotaynamduoc/blocs/search/search.dart';
import 'package:sotaynamduoc/injection_container.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  late SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _searchBloc = getIt<SearchBloc>();
    _searchBloc.add(const SearchInitialized());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _searchBloc.add(SearchQueryChanged(query));
  }

  void _onSearchSubmitted() {
    if (_searchController.text.isNotEmpty) {
      _searchBloc.add(SearchSubmitted(_searchController.text));
    }
  }

  void _onSearchCanceled() {
    _searchController.clear();
    _searchBloc.add(const SearchCleared());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _searchBloc,
      child: BaseScreen(
        body: const SearchBodyScreen(),
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
      ),
    );
  }
}
