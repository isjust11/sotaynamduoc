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
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: SearchBodyScreen(),
      customAppBar: BaseAppBar(
        title: AppLocalizations.current.youCanSearch,
        showBackButton: true,
        backgroundColor: AppColors.secondaryBrand,
      ),
    );
  }
}
